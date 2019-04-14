Introduction to nullable
==============================================================================

.. image:: https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png
   :height: 34
   :width: 131
   :alt: nimble

NULLABLE

Creates basic nim "types" that can, in addition to their normal values,
take on the values of Null or Error.

EXAMPLE FOR INTEGERS

Nim has a integer type integrated into the language called "int". It is
normally used like:

.. code:: nim

    var x: int = 5

This library introduces another "int" named "Nint". It can be used in a
much more flexible manner because it can also be set to ``null`` or
``error``.

.. code:: nim

    import nullable

    var y: Nint = null                  # storing "nothing"
    y = Error("something went wrong")   # storing an error instead
    y = 5                               # store an actual integer

    # you can still do standard stuff:

    var z = y       # z is now a Nint valued at 5
    z = y * 2       # z is now a Nint valued at 10
    echo "z = ", z  # the message 'z = 10' displays on the screen




Table Of Contents
=================

1. `Introduction to nullable <docs/index.rst>`__
2. Appendix: `nullable Reference <docs/nullable-ref.rst>`__
