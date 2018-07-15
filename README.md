C0 Testing Format
=================

This documents the format of C0 specifications, a superset of the ones used by
the 15-411 compilers class.

A C0 test is a file ending in `.l1`, `.l2`, `.l3`, `.l4`, `.c0`, or `.c1` where
one or more lines at the beginning of the file begin with `//test`.

```
<test> ::= //test [<arg>* =>] <spec> \n
<arg>  ::= -l<lib> | -d | -f<filename> --no-purity-check | --standard=<lang>
<lang> ::= l1 | l2 | l3 | l4 | c0 | c1
<spec> ::= return <num>      - Should return a specific quantity
         | error_parse       - Fails to parse
         | error_typecheck   - Fails on typechecking
         | error_static      - Fails on static analysis (purity checking)
         | error             - Fails in any of the error categories above
         | failure           - Calls the error() function
         | div-by-zero       - Arithmetic error
         | aritherror        - Arithmetic error (alias of div-by-zero)
         | infloop           - Should run, but will time out
         | abort             - Contract or assertion error
         | segfault          - Memory error
         | memerror          - Memory error (alias of segfault)
         | typecheck         - Pass all static checks. Do not link/run.
```

The `typecheck` spec means that the spec should pass _all_ static checks,
(including purity checking). These programs need not link or run.

Tests should be read line-by-line until the first line that does not begin
with `//test`. This allows us to write the following specification:

```
//test error_static
//test --no-purity-check => return 17
//test --no-purity-check -d => abort

bool test(int* x) {
  *x += 1;
  return false;
}

int main()
//@requires test(alloc(int));
{
  return 17;
}
```

The tests in this repository don't have a lot of organization, and are
mostly just grouped by author (fp: Frank Pfenning, wjl: William Lovas, rjs:
Robert Simmons).