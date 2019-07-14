nullable/noid General Documentation
==============================================================================

The ``nOid`` object type represents a "nullable" Oid.

It should behave just like the native 'Oid' type in most instances; except
where the possible ``null`` or Error states are involved.

Further details are in the "nOid Reference" page linked at the bottom.

Handling Declaration and Assignment
-----------------------------------
You will need need to explicity assign the variable to be of type ``nOid``
if using a literal number. That is because literal Oids default to
the built in data type of ``Oid``.

.. code:: nim

    import nullable

    var a = 3.nOid         # works
    var b: nOid = -4       # works
    var c = to_nOid(78)    # works
    var d = c              # also works
    a = -99                # still works

    var e = 23             # does not work; "e" will be an "Oid" instead

and, of course, you can assign the value to ``null``, but again, you must
be explicit when declaring the variable.

.. code:: nim

    import nullable

    var a = null.nOid      # works
    var b: nOid = null     # works
    var c = to_nOid(null)  # works
    var d = c              # also works
    a = null               # still works

    var e = null           # does NOT work; "e" will be unusable

Handling an "Ambiguous Call" Compiler Error
-------------------------------------------

You can *sometimes* encounter an "ambiguous call" error at compile-time. For example:

.. code:: nim

    import nullable
    var a: nOid = 3
    a = a + 2         # compiler error here!

You will get a compiler message similar to:

.. code:: text

    example.nim(3, 7) Error: ambiguous call; both system.-(x: Oid, y: Oid)[declared in
    ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nOid.-(a: nOid,
    b: nOid)[declared in src/nullable/nOid.nim(161, 5)] match for: (nOid, Oid literal(2))

Essentially, the nim compiler doesn't know whether to:

a. convert ``a`` to an Oid, add the numbers, and then convert the answer back to an ``nOid``, or

b. convert ``2`` to a ``nOid``, and then add the numbers as ``nOid``s

Hopefully, one day, the compiler will consider the assignment operation type
as higher priority and choose (b) when handling such conflict.

In the mean time, if you get such an error, explicity convert the value(s) to a ``nOid``. Such as:

.. code:: nim

    var a: nOid = 3
    a = a + 2.nOid




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
