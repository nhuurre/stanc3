open Core_kernel
open Middle

type type_mismatch = private
  | DataOnlyError
  | TypeMismatch of UnsizedType.t * UnsizedType.t * details option

and details = private
  | SuffixMismatch of unit Fun_kind.suffix * unit Fun_kind.suffix
  | ReturnTypeMismatch of UnsizedType.returntype * UnsizedType.returntype
  | InputMismatch of function_mismatch

and function_mismatch = private
  | ArgError of int * type_mismatch
  | ArgNumMismatch of int * int
[@@deriving sexp]

type signature_error =
  (UnsizedType.returntype * (UnsizedType.autodifftype * UnsizedType.t) list)
  * function_mismatch

type ('unique, 'error) generic_match_result =
  | UniqueMatch of 'unique
  | AmbiguousMatch of
      (UnsizedType.returntype * (UnsizedType.autodifftype * UnsizedType.t) list)
      list
  | SignatureErrors of 'error

(** The match result for general (non-variadic) functions *)
type 'fun_kind match_result =
  ( UnsizedType.returntype
    * (bool Fun_kind.suffix -> 'fun_kind)
    * Promotion.t list
  , signature_error list * bool )
  generic_match_result

val check_of_same_type_mod_conv :
  UnsizedType.t -> UnsizedType.t -> (Promotion.t, type_mismatch) result

val check_compatible_arguments_mod_conv :
     (UnsizedType.autodifftype * UnsizedType.t) list
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> (Promotion.t list, function_mismatch) result

val unique_minimum_promotion :
  ('a * Promotion.t list) list -> ('a * Promotion.t list, 'a list option) result

val find_compatible_rt :
     ( UnsizedType.returntype
     * (UnsizedType.autodifftype * UnsizedType.t) list
     * (bool Fun_kind.suffix -> 'fun_kind)
     * Common.Helpers.mem_pattern )
     list
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> 'fun_kind match_result

val stan_math_return_type :
     string
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> UnsizedType.returntype option

val operator_stan_math_return_type :
     Operator.t
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> (UnsizedType.returntype * Promotion.t list) option

val check_variadic_args :
     bool
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> UnsizedType.t
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> ( UnsizedType.t * Promotion.t list
     , (UnsizedType.autodifftype * UnsizedType.t) list * function_mismatch )
     result
(** Check variadic function arguments.
      If a match is found, returns [Ok] of the function type and a list of promotions (see [promote])
      If none is found, returns [Error] of the list of args and a function_mismatch.
     *)

val pp_signature_mismatch :
     Format.formatter
  -> string
     * UnsizedType.t list
     * ( ( ( UnsizedType.returntype
           * (UnsizedType.autodifftype * UnsizedType.t) list )
         * function_mismatch )
         list
       * bool )
  -> unit

val compare_errors : function_mismatch -> function_mismatch -> int
