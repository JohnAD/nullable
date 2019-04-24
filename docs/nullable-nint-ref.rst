nullable/nint Reference
==============================================================================

The following are the references for nullable/nint.



Types
=====



nint
---------------------------------------------------------

    .. code:: nim

        nint* = object
          stored_value: int       # defaults to 0
          null: bool              # defaults to false (not null)
          error: string           # defaults to ""
          hints: seq[Hint]        # defaults to empty


    *source line: 83*

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

    *source line: 126*



`*`
---------------------------------------------------------

    .. code:: nim

        proc `*`*(a: nint, b: nint): nint =

    *source line: 248*



`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: nint): nint =

    *source line: 218*



`-`
---------------------------------------------------------

    .. code:: nim

        proc `-`*(a: nint, b: nint): nint =

    *source line: 233*



`=`
---------------------------------------------------------

    .. code:: nim

        proc `=`*(n: var nint, src: nint) =

    *source line: 136*



error
---------------------------------------------------------

    .. code:: nim

        proc error*(n: var nint, msg: string) =

    *source line: 198*



has_error
---------------------------------------------------------

    .. code:: nim

        proc has_error*(n: nint): bool =

    *source line: 201*



is_good
---------------------------------------------------------

    .. code:: nim

        proc is_good*(n: nint): bool =

    *source line: 211*



is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*(n: nint): bool =

    *source line: 204*







Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <nullable-core-gen.rst>`__
    E. `nullable/core Reference <nullable-core-ref.rst>`__
