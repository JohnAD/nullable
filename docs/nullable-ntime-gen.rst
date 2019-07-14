nullable/ntime General Documentation
==============================================================================

The ``nTime`` object type represents a "nullable" Time.

It should behave just like the native 'Time' type in most instances; except
where the possible ``null`` or Error states are involved.

Further details are in the "nTime Reference" page linked at the bottom.

Handling Declaration and Assignment
-----------------------------------
You will need need to explicity assign the variable to be of type ``nTime``
if using a literal number. That is because literal Times default to
the built in data type of ``Time``.

.. code:: nim

    import nullable

    var a = 3.nTime         # works
    var b: nTime = -4       # works
    var c = to_nTime(78)    # works
    var d = c              # also works
    a = -99                # still works

    var e = 23             # does not work; "e" will be an "Time" instead

and, of course, you can assign the value to ``null``, but again, you must
be explicit when declaring the variable.

.. code:: nim

    import nullable

    var a = null.nTime      # works
    var b: nTime = null     # works
    var c = to_nTime(null)  # works
    var d = c              # also works
    a = null               # still works

    var e = null           # does NOT work; "e" will be unusable

Handling an "Ambiguous Call" Compiler Error
-------------------------------------------

You can *sometimes* encounter an "ambiguous call" error at compile-time. For example:

.. code:: nim

    import nullable
    var a: nTime = 3
    a = a + 2         # compiler error here!

You will get a compiler message similar to:

.. code:: text

    example.nim(3, 7) Error: ambiguous call; both system.-(x: Time, y: Time)[declared in
    ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nTime.-(a: nTime,
    b: nTime)[declared in src/nullable/nTime.nim(161, 5)] match for: (nTime, Time literal(2))

Essentially, the nim compiler doesn't know whether to:

a. convert ``a`` to an Time, add the numbers, and then convert the answer back to an ``nTime``, or

b. convert ``2`` to a ``nTime``, and then add the numbers as ``nTime``s

Hopefully, one day, the compiler will consider the assignment operation type
as higher priority and choose (b) when handling such conflict.

In the mean time, if you get such an error, explicity convert the value(s) to a ``nTime``. Such as:

.. code:: nim

    var a: nTime = 3
    a = a + 2.nTime




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
