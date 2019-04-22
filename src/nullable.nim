## Replacement basic nim types that can, in addition to their normal values,
## take on the values of ``null`` or ``Error``.
##
## Introduction
## ------------
##
## Nim has five basic types:
##
## - ``bool``
## - ``char``
## - ``string``
## - ``int`` (aka int32)
## - ``float`` (aka float64)
##
## Examples of their use:
##
## .. code:: nim
##
##     var x: int = 5
##     var my_flag: bool = true
##     var firstName: string
##
## This library introduces replacement types that are prefixed with the letter "n":
##
## - ``nbool``
## - ``nchar``
## - ``nstring``
## - ``nint``
## - ``nfloat``
##
## The primary difference when use these, it that in addition to the traditional
## values they type can have, you can also set it them ``null`` or ``Error``.
##
## .. code:: nim
##
##     import nullable
##
##     var x: nint = 5
##     var my_flag: nbool = true
##     var firstName: nstring
##
##     x = null                            # storing "nothing" instead
##     x = Error("something went wrong")   # storing an error instead
##     x = -3                              # store an actual integer
##
##     my_flag = null
##     firstName = Error("name not found")
##
##  The types largely behave like their counterparts:
##
## .. code:: nim
##
##     var z = x        # z is now a nint valued at -3
##     z = x * 2        # z is now a nint valued at -6
##     echo "z = ", z   # the message 'z = -6' displays on the screen
##
##
## Downsides
## ---------
##
## There are a few downsides to using this library. Most notably:
##
## - Performance cost: these nullable types are, underneath, full objects. As
##   such, they use more memory and are somewhat slower.
## - Compatibility. Unless a library is written to use ``nullable`` you *might*
##   need to convert nullable types to the correct types when passing as
##   parameters. The library has built-in converters, but certain circumstances
##   might prevent automatic conversion. Failure should be obvious when
##   compiling.
##
## Future Versions
## ---------------
##
## There are two planned expansions after version 1.0.0 is released:
##
## - Allow "log" information to be attached to a variable. It will be strictly
##   optional. With conditional compiling, no code should be added if not used.
## - Adding the following types:
##   - ``nint64`` (aka "long")
##   - ``ndate`` and ``ntimestamp``
##   - ``nOid``
##   - ``nDecimal``
##

import
  nullable/core as core,
  nullable/nint as nint

export
  core,
  nint
