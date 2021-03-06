(** Some plumbing for our compiler errors *)
open Middle

(** Our type of syntax error information *)
type syntax_error =
  | Lexing of string * Location.t
  | Include of string * Location.t
  | Parsing of string * Location_span.t

(** Exception for Syntax Errors *)
exception SyntaxError of syntax_error

(** Exception [SemanticError (loc, msg)] indicates a semantic error with message
    [msg], occurring at location [loc]. *)
exception SemanticError of (string * Location_span.t)

(** Exception for Fatal Errors. These should perhaps be left unhandled,
    so we can trace their origin. *)
exception FatalError of string

val fatal_error : ?msg:string -> unit -> 'a
(** Throw a fatal error reported by the toplevel *)

val pp_syntax_error : Format.formatter -> syntax_error -> unit
(** A syntax error message used when handling a SyntaxError *)

val pp_semantic_error : Format.formatter -> string * Location_span.t -> unit
(** A semantic error message used when handling a SemanticError *)

val warn_deprecated : Lexing.position * string -> unit
(** Warn that a language construct is deprecated *)

val without_warnings : ('a -> 'b) -> 'a -> 'b
(** Evaluate a function on an argument while discarding any warning messages generated by it (rather than printing them to stderr) *)
