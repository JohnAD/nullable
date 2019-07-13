nullable/nstring General Documentation
==============================================================================

The ``nstring`` object type represents a "nullable" string.

It should behave just like the native 'string' type in most instances; except
where the possible null, nothing, or Error states are involved.

Further details are in the "nstring Reference" page linked at the bottom.

Handling Declaration and Assignment
-----------------------------------
You will need need to explicity assign the variable to be of type ``nstring``
if using a literal string. That is because literal strings default to
the built in data type of ``string``.

.. code:: nim

    import nullable

    var a = "hello".nstring      # works
    var b: nstring = "hello"     # works
    var c = to_nstring("hello")  # works
    var d = c                    # also works
    a = "goodbye"                # still works

    var e = "hello"              # does not work; "e" will be an "string" instead

and, of course, you can assign the value to ``null`` or ``nothing``, but again,
you must be explicit when declaring the variable.

.. code:: nim

    import nullable

    var a = null(string)           # works
    var b: nstring = null(string)  # works
    var c = null(nstring)          # also works oddly enough

The error state for a ``nstring`` is set explicitly with the ``setError`` function.

.. code:: nim

    import nullable

    var a: nstring
    a.setError(ValueError(msg: "something went wrong"))




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
