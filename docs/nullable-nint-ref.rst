nullable/nint Reference
==============================================================================

The following are the references for nullable/nint.



Types
=====



nint
---------------------------------------------------------

    .. code:: nim

        nint* = object
          case kind: NullableKind
          of nlkValue:
          of nlkNothing:
          of nlkNull:
          of nlkError:
          hints: seq[Hint]


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

    *source line: 124*



`*`
---------------------------------------------------------

    .. code:: nim

        proc `*`*(a: nint, b: nint): nint =

    *source line: 375*

    Operator: MULTIPLY
    
    Represented by the asterisk "*" symbol, this operation multiplies two nint
    values together.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: nint): nint =

    *source line: 329*

    Operator: ADD
    
    Represented by the plus "+" symbol, this operation adds two nint
    values together.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`-`
---------------------------------------------------------

    .. code:: nim

        proc `-`*(a: nint, b: nint): nint =

    *source line: 352*

    Operator: SUBTRACT
    
    Represented by the minus "-" symbol, this operation subtracts two nint
    values from each other.
    
    If either value is ``null`` or errored, the result is an error.
    
    returns a new ``nint``


`<`
---------------------------------------------------------

    .. code:: nim

        proc `<`*(a: nint, b: nint): bool =

    *source line: 424*

    Operator: LESS-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    ``nint`` values.
    
    If either value is ``null``, the result is false
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: int, b: nint): bool =

    *source line: 503*

    Operator: EQUAL-TO (int vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: int): bool =

    *source line: 487*

    Operator: EQUAL-TO (nint vs int)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`==`
---------------------------------------------------------

    .. code:: nim

        proc `==`*(a: nint, b: nint): bool =

    *source line: 468*

    Operator: EQUAL-TO (nint vs nint)
    
    Represented by two equal symbols "==" symbol, this operation compares two
    ``nint`` values.
    
    If both values are ``null``, the result is true. If only one, then false.
    If either value is ``error``, the result is false.


`=`
---------------------------------------------------------

    .. code:: nim

        proc `=`*(n: var nint, src: nint) =

    *source line: 148*



`>`
---------------------------------------------------------

    .. code:: nim

        proc `>`*(a: nint, b: nint): bool =

    *source line: 446*

    Operator: GREATER-THAN
    
    Represented by the angle-bracket "<" symbol, this operation compares two
    ``nint`` values.
    
    If either value is ``null``, the result is false.
    If either value is ``error``, the result is false.


`div`
---------------------------------------------------------

    .. code:: nim

        proc `div`*(dividend: nint, divisor: nint): nint =

    *source line: 525*

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

    *source line: 256*

    Check to see if n has an error associated with it.
    
    .. code:: nim
    
        var a: nint = ValueError("Too small.")
        if a.has_error:
          echo "Error found: " & $a
    


has_value
---------------------------------------------------------

    .. code:: nim

        proc has_value*(n: nint): bool =

    *source line: 301*

    Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
    have an error. A newly declared ``nint`` defaults to 0 (zero) and is good.
    
    .. code:: nim
    
        var a: nint = 5
        if a.is_good:
          echo "a = " & $a
    


is_nothing
---------------------------------------------------------

    .. code:: nim

        proc is_nothing*(n: nint): bool =

    *source line: 271*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: nint = null
        if a.is_null:
          echo "It is null."
    


is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*(n: nint): bool =

    *source line: 286*

    Check to see if n is unknown (a null).
    
    .. code:: nim
    
        var a: nint = null
        if a.is_null:
          echo "It is null."
    


repr
---------------------------------------------------------

    .. code:: nim

        proc repr*(n: nint): string =

    *source line: 135*







Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <nullable-core-gen.rst>`__
    E. `nullable/core Reference <nullable-core-ref.rst>`__
