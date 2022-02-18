(** Type environments used during typechecking. Maps from strings to function or variable information *)

open Middle

(** Origin blocks, to keep track of where variables are declared *)
type originblock =
  | MathLibrary
  | Functions
  | Data
  | TData
  | Param
  | TParam
  | Model
  | GQuant
[@@deriving sexp]

(** Information available for each variable *)
type varinfo = {origin: originblock; global: bool; readonly: bool}
[@@deriving sexp]

type info =
  { type_: UnsizedType.t
  ; kind:
      [ `Variable of varinfo
      | `UserDeclared of Location_span.t
      | `StanMath
      | `UserDefined ] }
[@@deriving sexp]

type t

val stan_math_environment : t
(** A type environment which contains the Stan math library functions
*)

val find : t -> string -> info list

val add :
     t
  -> string
  -> Middle.UnsizedType.t
  -> [ `UserDeclared of Location_span.t
     | `StanMath
     | `UserDefined
     | `Variable of varinfo ]
  -> t
(** Add a new item to the type environment. Does not overwrite existing, but shadows *)

val set_raw : t -> string -> info list -> t
(** Overwrite the existing items bound to a name *)

val mem : t -> string -> bool
val iter : t -> (info list -> unit) -> unit

val nearest_ident : t -> string -> string option
(** The nearest identifier by edit distance, capped at edit distance 3 (if one exists) *)

val matching_function :
     t
  -> string
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> Ast.fun_kind SignatureMismatch.match_result
(** Searches for a function of the given name which can
    support the required argument types.
    Requires a unique minimum option under type promotion
*)

val matching_stanlib_function :
     string
  -> (UnsizedType.autodifftype * UnsizedType.t) list
  -> Ast.fun_kind SignatureMismatch.match_result
(** Same as [matching_function] but requires specifically that the function
    be from StanMath (uses [Environment.stan_math_environment])
*)
