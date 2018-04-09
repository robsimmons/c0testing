TESTING/REGRESSION HARNESS
Robert J. Simmons

This directory contains testing harnesses for C0 programs.

cymbol-test - tests the cymbol operational semantics interpreter [broken]
cc0-test    - tests the C0 compiler (cc0)
csharp-test - tests the C0 to C# compiler
gcc-test    - tests for agreement with C [not yet]

These tools test different subsets of the specification - for instance, the 
test for the c0in interpreter simply ignores any file that is expected to fail 
during compilation, and gcc-test checks only for successful compilation on 
files that cc0 is expected to compile and checks that gcc produces the correct 
result on files that are marked as agreeing with C.

===============================================================================
Specification format

Tests <test> describe the expected behavior of programs, and can take 
the following form: 

error           - Not a valid C0 program (compiler should give error).
runs            - Starts without problems (no link errors)
infloop         - Will run forever (or until an arbitrary timeout).
segfault        - Raises an invalid memory access exception (SIGSEGV).
div-by-zero     - Raises an arithmetic exception (SIGFPE).
return <int>    - Return the 32-bit signed integer <int>.
return *        - Returns without an error

Predicates <phi> describe implementations; "," binds tighter than "or"

lib             - Describes implementations that can load libraries
typecheck       - Describes implementations that only compile *precisely*
                  those programs that conform to cc0's static semantics
gc              - Describes garbage-collected implementations
safe            - Describes safe implemenations (array-bounds checking)
false           - Describes no implementations; this is used to signal
                  certain reasonable but quarantined "wontfix" bugs,
                  such as ones that regularly cause the VM compiler to
                  time out
<string>        - Every implementation has a name ("cc0_bare" or "cymbol",
                  and that precise name can be used as a predicate
!<phi>          - Inverts a predicate; binds as tightly as possible
<phi>, <phi>    - Describes implementations that obey two properties at once
<phi> or <phi>  - Describes implementations that obey one of two properties

Specifications <spec> describe full tests; "=>" binds tighter than ";"

<spec>; <spec>  - Requires that both specifications be satisfied
<phi> => <spec> - Requires that <spec> be satisfied if <phi> is true
<test>          - Requires that a specific test pass

===============================================================================
Writing specifications

Specifications can go either on the first line of a .c0 file or in a .test
file. For the sake of sanity, each directory should contain tests *either*
in the .c0 files or in a single file sources.test.

If included files have a .c0 extension, they are ignorned silently unless the 
first line has this form:
 
   //test <test>

where <spec> describes the expected behavor of compiling and running that file.

If included files have a .test extension, they are expected to have only empty
lines and lines with this form:

   <test> ~ <filenames and compiler flags>

where <spec> describes the expected behavor of compiling and running all the
listed files as one program.

===============================================================================
Building and running the tools

The test for xxx can be built either with MLton or with SML-NJ on any Posix-
compliant system; some have specific options as well.

Specific tools have different options; running the tools with no arguments 
causes them to print out a description of their specific options.

With MLton installed:
$ make xxx-test
$ bin/xxx-test <filename 1> <filename 2> ...

With SML-NJ installed:
$ sml -m tests/drivers/xxx-test.cm
- Test.go ["<filename 1>", "<filename 2>", ...]

