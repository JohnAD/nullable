nullable/nfloat Reference
==============================================================================

The following are the references for nullable/nfloat.






Procs and Methods
=================


`*`
---------------------------------------------------------

    .. code:: nim

        proc `*`*(a: nfloat, b: nfloat): nfloat =

    *source line: 232*

    Operator: MULTIPLY
    
    Represented by the asterisk "*" symbol, this operation multiplies two nfloat
    values together.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if either value is ``nothing``, the results is zero.
    
    returns a new ``nfloat``


`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nfloat, b: nfloat): nfloat =

    *source line: 154*

    Operator: ADD
    
    Represented by the plus "+" symbol, this operation adds two nfloat
    values together.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if one value is ``nothing``, the nothing is treated as zero
    if both values are nothing, the result is nothing
    
    returns a new ``nfloat``


`-`
---------------------------------------------------------

    .. code:: nim

        proc `-`*(a: nfloat, b: nfloat): nfloat =

    *source line: 193*

    Operator: SUBTRACT
    
    Represented by the minus "-" symbol, this operation subtracts two nfloat
    values from each other.
    
    If either value is errored, the result is an error.
    If either value is null, the result is null.
    if one value is ``nothing``, the nothing is treated as zero
    if both values are nothing, the result is nothing
    
    returns a new ``nfloat``


`<`
---------------------------------------------------------

    .. code:: nim

        proc `<`*(a: nfloat, b: nfloat): bool =

    *source line: 288*

    Operator: LESS-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    values.
    
    If a is ``Nothing``, and b has a value, then the results is always true.
    If either value is ``null`` or ``error``, the result is false


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: float, b: nfloat): bool =

    *source line: 372*

    Operator: EQUAL-TO (float vs nfloat)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nfloat, b: float): bool =

    *source line: 357*

    Operator: EQUAL-TO (nfloat vs float)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    values.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nfloat, b: nfloat): bool =

    *source line: 336*

    Operator: EQUAL-TO (nfloat vs nfloat)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nfloat`` values.
    
    If either value is null, then it returns false.
    If either value is ``error``, the result is false.
    If both are nothing, then true. If only one is nothing, then false.


`>`
---------------------------------------------------------

    .. code:: nim

        proc `>`*(a: nfloat, b: nfloat): bool =

    *source line: 312*

    Operator: GREATER-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    values.
    
    If a has a value and b is ``Nothing``, then the result is always true.
    If either value is ``null`` or ``error``, the result is false.


`div`
---------------------------------------------------------

    .. code:: nim

        proc `div`*(dividend: nfloat, divisor: nfloat): nfloat =

    *source line: 393*

    Operator: INTEGER_DIVIDE
    
    This operation divides two nfloat values and returns only the float
    quotient.
    
    If either value is ``null`` or errored, the result is an error.
    If the divisor is zero, the result is an error.
    
    returns a new ``nfloat``






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
