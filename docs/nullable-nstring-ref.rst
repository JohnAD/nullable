nullable/nstring Reference
==============================================================================

The following are the references for nullable/nstring.






Procs and Methods
=================


`&`
---------------------------------------------------------

    .. code:: nim

        proc `&`*(a: nstring, b: nstring): nstring =

    *source line: 249*

    Operator: AND
    
    As always, "error override null" and "null overrides value (or nothing)"
    If either a or b are error, the result is the cumulative error
    If either a or b are null, the result is null
    If either a or b are nothing, it is treated as a "". If both are nothing,
      then the result is nothing.


`<`
---------------------------------------------------------

    .. code:: nim

        proc `<`*(a: nstring, b: nstring): bool =

    *source line: 157*

    Operator: LESS-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    strings for alphabetical order.
    
    If a is ``Nothing``, and b has a value, then the results is always true.
    If either value is ``null`` or ``error``, the result is false


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nstring, b: nstring): bool =

    *source line: 203*

    Operator: EQUAL-TO (nstring vs nstring)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nstring`` values.
    
    If either value is null, then it returns false.
    If either value is ``error``, the result is false.
    If both are nothing, then true. If only one is nothing, then false.
    
    Very specifically: nothing(string) != "".nstring


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nstring, b: string): bool =

    *source line: 226*

    Operator: EQUAL-TO (nstring vs nstring)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nstring`` values.
    
    If a is null, then it returns false.
    If a is ``error``, the result is false.
    If a is nothing, then false.


`>`
---------------------------------------------------------

    .. code:: nim

        proc `>`*(a: nstring, b: nstring): bool =

    *source line: 180*

    Operator: GREATER-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    strings for alphaetical order.
    
    If a has a value and b is ``Nothing``, then the result is always true.
    If either value is ``null`` or ``error``, the result is false.






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
