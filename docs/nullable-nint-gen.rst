nullable/nint General Documentation
==============================================================================

module for ``nint``

The ``nint`` object should behave just like the native 'int' type
in most instances.

Sadly, nim does not yet object types in full-parity manner yet, so you
will *sometimes* encounter an "ambiguous call" error. For example:

.. code:: nim

    import nullable
    var a: nint = 3
    a = a + 2

You will get a compiler message similar to:

.. code:: text

    example.nim(3, 7) Error: ambiguous call; both system.-(x: int, y: int)[declared in
    ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nint.-(a: nint,
    b: nint)[declared in src/nullable/nint.nim(161, 5)] match for: (nint, int literal(2))

Essentially, the nim compiler doesn't know whether to:

- convert ``a`` to an int, add the numbers, and then convert the plus operation back to an ``nint``, or

- convert ``2`` to a ``nint``, and then add the numbers

Hopefully, one day, the compiler will consider the assignment operation type as higher priority when handling such conflict.

In the mean time, if you get such an error, explicity convert the value to a ``nint`` with ``to_nint``. Such as:

.. code:: nim

    var a: nint = 3
    a = a + to_nint(2)




Table Of Contents
=================

1. `Introduction to nullable <index.rst>`__
2. Appendices

    A. `nullable Reference <nullable-ref.rst>`__
    B. `nullable/nint General Documentation <nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <nullable-core-gen.rst>`__
    E. `nullable/core Reference <nullable-core-ref.rst>`__
