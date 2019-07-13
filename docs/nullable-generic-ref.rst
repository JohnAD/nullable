nullable/generic Reference
==============================================================================

The following are the references for nullable/generic.






Procs and Methods
=================


`$`
---------------------------------------------------------

    .. code:: nim

        proc `$`*[T](n: Nullable[T]): string =

    *source line: 29*



actualSetError
---------------------------------------------------------

    .. code:: nim

        proc actualSetError*[T](n: var Nullable[T], e: Nullable[T], loc: string) =

    *source line: 76*



actualSetError
---------------------------------------------------------

    .. code:: nim

        proc actualSetError*[T](n: var Nullable[T], e: ValidErrors, loc: string) =

    *source line: 67*



get
---------------------------------------------------------

    .. code:: nim

        proc get*[T](n: Nullable[T]): T =

    *source line: 40*



has_error
---------------------------------------------------------

    .. code:: nim

        proc has_error*[T](n: Nullable[T]): bool =

    *source line: 86*

    Check to see if n has an error associated with it.
    
    .. code:: nim
    
        var a: Nullable[T] = ValueError("Too small.")
        if a.has_error:
          echo "Error found: " & $a
    


has_value
---------------------------------------------------------

    .. code:: nim

        proc has_value*[T](n: Nullable[T]): bool =

    *source line: 131*

    Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
    have an error. A newly declared ``Nullable[T]`` defaults to 0 (zero) and is good.
    
    .. code:: nim
    
        var a: Nullable[T] = 5
        if a.is_good:
          echo "a = " & $a
    


is_nothing
---------------------------------------------------------

    .. code:: nim

        proc is_nothing*[T](n: Nullable[T]): bool =

    *source line: 101*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: Nullable[T] = null
        if a.is_null:
          echo "It is null."
    


is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*[T](n: Nullable[T]): bool =

    *source line: 116*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: Nullable[T] = null
        if a.is_null:
          echo "It is null."
    


repr
---------------------------------------------------------

    .. code:: nim

        proc repr*[T](n: Nullable[T]): string =

    *source line: 47*







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
