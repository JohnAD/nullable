nullable/nint Reference
==============================================================================

The following are the references for nullable/nint.






Procs and Methods
=================


`*`
---------------------------------------------------------

    .. code:: nim

        proc `*`*(a: nint, b: nint): nint =

    *source line: 272*

    Operator: MULTIPLY
    
    Represented by the asterisk "*" symbol, this operation multiplies two nint
    values together.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if either value is ``nothing``, the results is zero.
    
    returns a new ``nint``


`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: nint): nint =

    *source line: 194*

    Operator: ADD
    
    Represented by the plus "+" symbol, this operation adds two nint
    values together.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if one value is ``nothing``, the nothing is treated as zero
    if both values are nothing, the result is nothing
    
    returns a new ``nint``


`-`
---------------------------------------------------------

    .. code:: nim

        proc `-`*(a: nint, b: nint): nint =

    *source line: 233*

    Operator: SUBTRACT
    
    Represented by the minus "-" symbol, this operation subtracts two nint
    values from each other.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if one value is ``nothing``, the nothing is treated as zero
    if both values are nothing, the result is nothing
    
    returns a new ``nint``


`<`
---------------------------------------------------------

    .. code:: nim

        proc `<`*(a: nint, b: nint): bool =

    *source line: 328*

    Operator: LESS-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    values.
    
    If a is ``Nothing``, and b has a value, then the results is always true.
    If either value is ``null`` or ``error``, the result is false


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: int, b: nint): bool =

    *source line: 412*

    Operator: EQUAL-TO (int vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: int): bool =

    *source line: 397*

    Operator: EQUAL-TO (nint vs int)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: nint): bool =

    *source line: 376*

    Operator: EQUAL-TO (nint vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If either value is null, then it returns false.
    If either value is ``error``, the result is false.
    If both are nothing, then true. If only one is nothing, then false.


`>`
---------------------------------------------------------

    .. code:: nim

        proc `>`*(a: nint, b: nint): bool =

    *source line: 352*

    Operator: GREATER-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    values.
    
    If a has a value and b is ``Nothing``, then the result is always true.
    If either value is ``null`` or ``error``, the result is false.


`div`
---------------------------------------------------------

    .. code:: nim

        proc `div`*(dividend: nint, divisor: nint): nint =

    *source line: 433*

    Operator: INTEGER_DIVIDE
    
    This operation divides two nint values and returns only the integer
    quotient.
    
    If either value is ``null`` or errored, the result is an error.
    If the divisor is zero, the result is an error.
    
    returns a new ``nint``






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
    P. `nullable/core General Documentation <nullable-core-gen.rst>`__
    Q. `nullable/core Reference <nullable-core-ref.rst>`__
    R. `nullable/nchar General Documentation <nullable-nchar-gen.rst>`__
    S. `nullable/nchar Reference <nullable-nchar-ref.rst>`__
    T. `nullable/norm/mongodb General Documentation <nullable-norm-mongodb-gen.rst>`__
    U. `nullable/norm/mongodb Reference <nullable-norm-mongodb-ref.rst>`__
