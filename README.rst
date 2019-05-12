Introduction to nullable
==============================================================================

.. image:: https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png
   :height: 34
   :width: 131
   :alt: nimble

Replacement basic nim types that can, in addition to their normal values,
take on the values of ``null`` or ``Error``.

Introduction
------------

Nim has five basic types:

- ``bool``

- ``char``

- ``string``

- ``int`` (aka int32)

- ``float`` (aka float64)

Examples of their use:

.. code:: nim

    var x: int = 5
    var my_flag: bool = true
    var firstName: string

This library introduces replacements. The names are prefixed with the letter "n":

- ``nbool``

- ``nchar``

- ``nstring``

- ``nint``

- ``nfloat``

The primary difference when use these, it that in addition to the traditional
values they type can have, you can also set it them ``null`` or ``Error``.

.. code:: nim

    import nullable

    var x: nint = 5
    var my_flag: nbool = true
    var firstName: nstring

    x = null                                 # storing "nothing"/null
    x = ValueError("Something went wrong.")  # storing an error
    x = -3                                   # store an actual integer

    my_flag = null
    firstName = IOError("Name not found.")

The types largely behave like their counterparts:

.. code:: nim

    var z = x        # z is now a nint valued at -3
    z = x * 2        # z is now a nint valued at -6
    echo "z = ", z   # the message 'z = -6' displays on the screen


The True Meaning of Null
------------------------

The meaning of ``null`` is based on the ANSI SQL meaning of the word:

> Null is a value that is UNKNOWN.

It does NOT mean "a missing value". The semantic difference is
subtle but very important. For example, if you where to ADD a missing value
to the number 2, you would expect the answer to be two. After all, if something
is not there, it implies zero. But ``null`` does not work that way. Adding
2 to an unknown value is another new unknown value. The answer is "two plus
some number we don't know." Therefore:

.. code:: nim

    var a: nint = null
    var b: nint = 2
    var c: nint
    c = a + b
    echo "c = ", c
    echo a.is_null    # this is the best way to detect null
    echo (a == null)  # this is a tricky one: both "a" and "null" are DIFFERENT unknown values

results in an output of:

.. code::

    c = null
    true
    false

Downsides
---------

There are a few downsides to using this library. Most notably:

- **Performance cost**: these nullable types are, underneath, full objects. As
  such, they use more memory and are somewhat slower.

- **Compatibility**. Unless a library is written to use ``nullable`` you *might*
  need to convert nullable types to the correct types when passing as
  parameters. The library has built-in converters, but certain circumstances
  might prevent automatic conversion. A failure message *should* be generated when
  compiling.

Future Versions
---------------

There are two planned expansions after version 1.0.0 is released:

- Allow "hint" information to be attached to a variable. This will be strictly
  optional. With conditional compiling, no code should be added if not used.

- Adding the following types:

  - nint64 (aka "long")

  - ndate and ntimestamp

  - nOid

  - nDecimal




Table Of Contents
=================

1. `Introduction to nullable <docs/index.rst>`__
2. Appendices

    A. `nullable Reference <docs/nullable-ref.rst>`__
    B. `nullable/nint General Documentation <docs/nullable-nint-gen.rst>`__
    C. `nullable/nint Reference <docs/nullable-nint-ref.rst>`__
    D. `nullable/core General Documentation <docs/nullable-core-gen.rst>`__
    E. `nullable/core Reference <docs/nullable-core-ref.rst>`__
