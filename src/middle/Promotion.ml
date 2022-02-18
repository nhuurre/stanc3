open Core_kernel.Poly

(** Type to represent promotions in the typechecker.
  This can be used to return information about how to promote
  expressions for use in [Ast.Promotion] *)
type t =
  | NoPromotion
  | IntToReal
  | ToVar (* used in arrays, not functions *)
  | ToComplexVar (* used in arrays, not functions *)
  | IntToComplex
  | RealToComplex

(** Get the promotion needed to make the second type into the first.
  Types NEED to have previously been checked to be promotable
*)
let rec get_type_promotion_exn (ad, ty) (ad2, ty2) =
  match (ty, ty2) with
  | UnsizedType.(UReal, (UReal | UInt) | UVector, UVector | UMatrix, UMatrix)
    when ad <> ad2 ->
      ToVar
  | UComplex, (UReal | UInt | UComplex) when ad <> ad2 -> ToComplexVar
  | UReal, UInt -> IntToReal
  | UComplex, UInt -> IntToComplex
  | UComplex, UReal -> RealToComplex
  | UArray nt1, UArray nt2 -> get_type_promotion_exn (ad, nt1) (ad2, nt2)
  | t1, t2 when t1 = t2 -> NoPromotion
  | _, _ ->
      Common.FatalError.fatal_error_msg
        [%message
          "Tried to get promotion of mismatched types!"
            (ty : UnsizedType.t)
            (ty2 : UnsizedType.t)]

(** Calculate the "cost"/number of promotions performed.
    Used to disambiguate function signatures
*)
let promotion_cost p =
  match p with
  | NoPromotion | ToVar | ToComplexVar -> 0
  | RealToComplex | IntToReal -> 1
  | IntToComplex -> 2
