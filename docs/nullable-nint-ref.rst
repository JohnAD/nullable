nullable/nint Reference
==============================================================================

The following are the references for nullable/nint.



Types
=====



nint
---------------------------------------------------------

    .. code:: nim

        nint* = object
          stored_value: int            # defaults to 0
          null: bool                   # defaults to false (not null)
          error: ExceptionClass   # defaults to empty
          hints: seq[Hint]             # defaults to empty


    *source line: 84*

    The object used to represent the ``nint`` data type.
    
    Please note that elements are not directly accessible. You cannot
    do this:
    
    .. code:: nim
    
        var a: nint = 3
        echo "a = ", $a.stored_value
    
    that will generate a compiler error. Instead, rely on the libraries
    ability to convert and adjust as needed. So, simply:
    
    .. code:: nim
    
        var a: nint = 3
        echo "a = ", $a
    
    or possibly:
    
    .. code:: nim
    
        var a: nint = 3
        var b: int = a
        echo "b = ", $b
    






Procs and Methods
=================


`$`
---------------------------------------------------------

    .. code:: nim

        proc `$`*(n: nint): string =

    *source line: 127*



`*`
---------------------------------------------------------

    .. code:: nim

        proc `*`*(a: nint, b: nint): nint =

    *source line: 290*

    Operator: MULTIPLY
    
    Represented by the asterisk "*" symbol, this operation multiplies two nint
    values together.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: nint): nint =

    *source line: 244*

    Operator: ADD
    
    Represented by the plus "+" symbol, this operation adds two nint
    values together.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`-`
---------------------------------------------------------

    .. code:: nim

        proc `-`*(a: nint, b: nint): nint =

    *source line: 267*

    Operator: SUBTRACT
    
    Represented by the minus "-" symbol, this operation subtracts two nint
    values from each other.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`<`
---------------------------------------------------------

    .. code:: nim

        proc `<`*(a: nint, b: nint): bool =

    *source line: 339*

    Operator: LESS-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    ``nint`` values.
    
    If either value is ``null``, the result is false
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: int, b: nint): bool =

    *source line: 418*

    Operator: EQUAL-TO (int vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: int): bool =

    *source line: 402*

    Operator: EQUAL-TO (nint vs int)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: nint): bool =

    *source line: 383*

    Operator: EQUAL-TO (nint vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`=`
---------------------------------------------------------

    .. code:: nim

        proc `=`*(n: var nint, src: nint) =

    *source line: 137*



`>`
---------------------------------------------------------

    .. code:: nim

        proc `>`*(a: nint, b: nint): bool =

    *source line: 361*

    Operator: GREATER-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    ``nint`` values.
    
    If either value is ``null``, the result is false.
    If either value is ``error``, the result is false.


`div`
---------------------------------------------------------

    .. code:: nim

        proc `div`*(dividend: nint, divisor: nint): nint =

    *source line: 440*

    Operator: INTEGER_DIVIDE
    
    This operation divides two nint values and returns only the integer
    quotient.
    
    If either value is ``null`` or errored, the result is an error.
    If the divisor is zero, the result is an error.
    
    returns a new ``nint``


has_error
---------------------------------------------------------

    .. code:: nim

        proc has_error*(n: nint): bool =

    *source line: 220*



is_good
---------------------------------------------------------

    .. code:: nim

        proc is_good*(n: nint): bool =

    *source line: 228*



is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*(n: nint): bool =

    *source line: 224*







Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <nullable-core-gen.rst>`__
    E. `nullable/core Reference <nullable-core-ref.rst>`__
