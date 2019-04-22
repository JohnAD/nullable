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


    *source line: 7*







Procs and Methods
=================


`$`
---------------------------------------------------------

    .. code:: nim

        proc `$`*(n: nint): string =

    *source line: 15*



`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: int, b: nint): nint =

    *source line: 77*



`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: int): nint =

    *source line: 69*



`+`
---------------------------------------------------------

    .. code:: nim

        proc `+`*(a: nint, b: nint): nint =

    *source line: 57*



`=`
---------------------------------------------------------

    .. code:: nim

        proc `=`*(n: var nint, src: nint) =

    *source line: 24*



error
---------------------------------------------------------

    .. code:: nim

        proc error*(n: var nint, msg: string) =

    *source line: 39*



has_error
---------------------------------------------------------

    .. code:: nim

        proc has_error*(n: nint): bool =

    *source line: 42*



is_good
---------------------------------------------------------

    .. code:: nim

        proc is_good*(n: nint): bool =

    *source line: 50*



is_null
---------------------------------------------------------

    .. code:: nim

        proc is_null*(n: nint): bool =

    *source line: 45*







Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <nullable-core-gen.rst>`__
    E. `nullable/core Reference <nullable-core-ref.rst>`__
