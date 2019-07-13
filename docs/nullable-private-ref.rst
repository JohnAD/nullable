nullable/private Reference
==============================================================================

The following are the references for nullable/private.



Types
=====



ValidErrors
---------------------------------------------------------

    .. code:: nim

        ValidErrors* = ValueError | ArithmeticError | ResourceExhaustedError | OSError | IOError


    *source line: 10*







Procs and Methods
=================


`$`
---------------------------------------------------------

    .. code:: nim

        proc `$`*(n: target): string =

    *source line: 27*



`=`
---------------------------------------------------------

    .. code:: nim

        proc `=`*(n: var target, src: target) =

    *source line: 51*



actualSetError
---------------------------------------------------------

    .. code:: nim

        proc actualSetError*(n: var target, e: ValidErrors, loc: string) =

    *source line: 82*



actualSetError
---------------------------------------------------------

    .. code:: nim

        proc actualSetError*(n: var target, e: target, loc: string) =

    *source line: 91*



get_value
---------------------------------------------------------

    .. code:: nim

        proc get_value*(n: target): typ =

    *source line: 63*



has_error
---------------------------------------------------------

    .. code:: nim

        proc has_error*(n: target): bool =

    *source line: 97*

    Check to see if n has an error associated with it.
    
    .. code:: nim
    
        var a: nint = ValueError("Too small.")
        if a.has_error:
          echo "Error found: " & $a
    


has_value
---------------------------------------------------------

    .. code:: nim

        proc has_value*(n: target): bool =

    *source line: 142*

    Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
    have an error. A newly declared ``nint`` defaults to 0 (zero) and is good.
    
    .. code:: nim
    
        var a: nint = 5
        if a.is_good:
          echo "a = " & $a
    


is_nothing
---------------------------------------------------------

    .. code:: nim

        proc is_nothing*(n: target): bool =

    *source line: 112*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: nint = null
        if a.is_null:
          echo "It is null."
    


is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*(n: target): bool =

    *source line: 127*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: nint = null
        if a.is_null:
          echo "It is null."
    


repr
---------------------------------------------------------

    .. code:: nim

        proc repr*(n: target): string =

    *source line: 38*







Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/nfloat General Documentation <nullable-nfloat-gen.rst>`__
    E. `nullable/nfloat Reference <nullable-nfloat-ref.rst>`__
    F. `nullable/noid General Documentation <nullable-noid-gen.rst>`__
    G. `nullable/noid Reference <nullable-noid-ref.rst>`__
    H. `nullable/generic General Documentation <nullable-generic-gen.rst>`__
    I. `nullable/generic Reference <nullable-generic-ref.rst>`__
    J. `nullable/ntime General Documentation <nullable-ntime-gen.rst>`__
    K. `nullable/ntime Reference <nullable-ntime-ref.rst>`__
    L. `nullable/nbool General Documentation <nullable-nbool-gen.rst>`__
    M. `nullable/nbool Reference <nullable-nbool-ref.rst>`__
    N. `nullable/nstring General Documentation <nullable-nstring-gen.rst>`__
    O. `nullable/nstring Reference <nullable-nstring-ref.rst>`__
    P. `nullable/private General Documentation <nullable-private-gen.rst>`__
    Q. `nullable/private Reference <nullable-private-ref.rst>`__
    R. `nullable/core General Documentation <nullable-core-gen.rst>`__
    S. `nullable/core Reference <nullable-core-ref.rst>`__
    T. `nullable/norm/mongodb General Documentation <nullable-norm-mongodb-gen.rst>`__
    U. `nullable/norm/mongodb Reference <nullable-norm-mongodb-ref.rst>`__
