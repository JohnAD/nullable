nullable/core Reference
==============================================================================

The following are the references for nullable/core.



Types
=====



Audience
---------------------------------------------------------

    .. code:: nim

        Audience* = enum
          ops,
          admin,
          user,
          public


    *source line: 29*

    Distribution limits for news of a hint.
    
    ops
      only seen by those with server/system maintainer clearance
    
    admin
      only seen by end-users with admin clearance (and ops)
    
    user
      only seen by regular users (and admin and ops)
    
    public
      the whole world (no restrictions)


ExceptionClass
---------------------------------------------------------

    .. code:: nim

        ExceptionClass* = object
          msg*: string
          exception_type*: string
          trace*: string


    *source line: 69*



Hint
---------------------------------------------------------

    .. code:: nim

        Hint* = object
          msg*: string           # defaults to ""
          level*: Level          # defaults to 'lvlAll'
          judgement*: Judgement  # defaults to 'info'
          audience*: Audience    # defaults to 'ops'


    *source line: 64*



Judgement
---------------------------------------------------------

    .. code:: nim

        Judgement* = enum
          info,
          success,
          warning,
          danger


    *source line: 8*

    Category of judgement for a hint.
    
    info
        neutral (but ok if forced to judge)
    
    success
        ok
    
    warning
        ok; but with reservations
    
    danger
        not ok
    
    These categories are inspired by the Bootstrap framework
    (https://getbootstrap.com/)


NothingClass
---------------------------------------------------------

    .. code:: nim

        NothingClass* = object
          exists: bool


    *source line: 62*



NullClass
---------------------------------------------------------

    .. code:: nim

        NullClass* = object
          exists: bool          # note: this field is not actually used.


    *source line: 60*



NullableKind
---------------------------------------------------------

    .. code:: nim

        NullableKind* = enum
          nlkValue,
          nlkNothing,
          nlkNull,
          nlkError
          # state_valued,
          # state_nothing,
          # state_nulled,
          # state_errored


    *source line: 49*







Procs and Methods
=================


`$`
---------------------------------------------------------

    .. code:: nim

        proc `$`*(e: ExceptionClass): string =

    *source line: 79*



error_repr
---------------------------------------------------------

    .. code:: nim

        proc error_repr*(err_list: seq[ExceptionClass]): string =

    *source line: 82*







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
