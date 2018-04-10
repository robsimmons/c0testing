C0 Testing Format
=================

This documents the format of C0 specifications, a superset of the ones used by
the 15-411 compilers class.

A C0 test is a file ending in `.l1`, `.l2`, `.l3`, `.l4`, `.c0`, or `.c1` where
one or more lines at the beginning of the file begin with `//test`.

```
<test> ::= //test [<arg>* =>] <spec> \n
<arg>  ::= -l<lib> | -d | --no-purity-check
<spec> ::= return <num>      - Should return a specific quantity
         | error_parse       - Fails to parse
         | error_typecheck   - Fails on typechecking
         | error_static      - Fails on static analysis (purity checking)
         | error_runtime     - Calls the error() function
         | error             - Fails in any of the error categories above
         | div-by-zero       - Arithmetic error
         | infloop           - Should run, but will time out
         | abort             - Contract or assertion error
         | memerror          - Memory error
         | typecheck         - Pass all static checks. Do not link/run.
```

The `typecheck` spec is a misnomer, it should pass all static checks, including
purity checking.

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
