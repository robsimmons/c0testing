# Tests can be matched at the beginning of a file using the regular expression
# /(\/\/test.*\n)*/; the matching string then matches against this grammar.

Tests -> ("//test" (_ (Arg _):* "=>"):? _ Spec _ ("\r" | "\n" | "\r\n" | "\n\r")):*
Arg   -> "-l" [a-zA-Z]:+ | "-d" | "--no-purity-check" | "--standard" _ "=" _ Lang
Lang  -> "l1" | "l2" | "l3" | "l4" | "c0" | "c1"
Spec  -> "return" _ "-":? [0-9]:+
       | "error_parse"
       | "error_typecheck"
       | "error_static"
       | "error_runtime"
       | "error"
       | "div-by-zero"
       | "aritherror"
       | "infloop"
       | "abort"
       | "segfault"
       | "memerror"
       | "typecheck"

_     -> " ":*
