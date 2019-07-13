nullable/nbool Reference
==============================================================================

The following are the references for nullable/nbool.






Procs and Methods
=================


`!`
---------------------------------------------------------

    .. code:: nim

        proc `!`*(a: nbool): bool =

    *source line: 249*

    Operator: NOT (bool)
    


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: bool, b: nbool): bool =

    *source line: 222*

    Operator: EQUAL-TO (bool vs nbool)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nbool, b: bool): bool =

    *source line: 207*

    Operator: EQUAL-TO (nbool vs bool)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nbool, b: nbool): bool =

    *source line: 186*

    Operator: EQUAL-TO (nbool vs nbool)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nbool`` values.
    
    If either value is null, then it returns false.
    If either value is ``error``, the result is false.
    If both are nothing, then true. If only one is nothing, then false.






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
