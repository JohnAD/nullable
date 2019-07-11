## Replacement basic nim types that can, in addition to their normal values,
## take on the values of ``nothing``, ``null`` or an Error object.
##
## Introduction
## ============
##
## Nim has five basic types:
##
## - ``bool``
## 
## - ``char``
## 
## - ``string``
## 
## - ``int`` (aka int32)
## 
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
## This library introduces replacements. The names are prefixed with the letter "n":
##
## - ``nbool``
## 
## - ``nchar``
## 
## - ``nstring``
## 
## - ``nint``
## 
## - ``nfloat``
##
## The primary difference when use these, it that in addition to the traditional
## values they type can have, you can also set it them ``nothing``, ``null`` or 
## ``Error``.
##
## .. code:: nim
##
##     import nullable
##
##     var x: nint = 5
##     var my_flag: nbool = true
##     var firstName: nstring
##
##     x = null                                      # storing "unknown"/null
##     x = ValueError(msg: "Something went wrong.")  # storing an error
##     x = -3                                        # store an actual integer
##
##     my_flag = nothing
##     firstName = IOError(msg: "Name not found.")
##
## The types largely behave like their counterparts:
##
## .. code:: nim
##
##     var x: nint = -3
##     var z = x        # z is a nint valued at -3
##     z = x * 2        # z is now a nint valued at -6
##     echo "z = ", z   # the message 'z = -6' displays on the screen
##
##
## Null vs. Nothing
## ================
##
## In general spoken language, "nothing" and "null" have similar meanings. But,
## in this library they have very specific and explicitly different meanings:
##
##     | Nothing is a non-value. It is a value that DOES NOT EXIST or SHOULD NOT EXIST.
##
## But, the meaning of ``null`` is based on the ANSI SQL meaning of the word:
##
##     | Null is a value that is UNKNOWN, but might be discovered one day.
##
## Some quick examples of the difference:
##
## .. code:: nim
## 
##     assert( nothing(nint) == nothing(nint) )
##     assert( null(nint) != null(nint) )
##
##     assert( (nothing(nint) + 4).isError )
##     assert( (null(nint) + 4) == null(nint) )
##
##     var mySeq: seq[nint] = @[-9, null(nint), 3]
##     assert( count(mySeq) == 2 )
##     assert( len(mySeq) == 3 )
##     assert( sum(mySeq) == -6 )
##
## Simply put, an "unknown" value (``null``) cannot be assumed to be the same as another
## "unknown" value. This is in keeping with the term's meaning in databases.
##
## Aggregation functions (such as ``sum`` or ``count``) simply ignore the ``nothing`` or
## ``null`` entries. This is also consistent with SQL and other database types.
##
## .. code:: nim
## 
##     import nullable/json
## 
##     var j = %* {
##       "name": "Bob",
##       "grandchildren": 0,
##       "windturbine_category": nothing(nstring),
##       "age": null(nstring),
##       "other": @["J", null(nint), 4, nothing(nint), 3.2]
##     }
##
##     let expected = """{
##       "name": "Bob",
##       "grandchildren": 0,
##       "age": null,
##       "other": ["J", null, 4, 3.2]
##     }"""
## 
##     assert( expected == pretty(j) )
##
## Notice that in JSON, a value that does not exist (``nothing``) is simply
## skipped. Whereas an unknown value (``null``) is stored as a JSON ``null``.
##
## Downsides
## =========
##
## There are a few downsides to using this library. Most notably:
##
## - **Performance cost**: these nullable types are, underneath, full objects. As
##   such, they use more memory and are somewhat slower.
## 
## - **Compatibility**. Unless a library is written to use ``nullable`` you *might*
##   need to convert nullable types to the correct types when passing as
##   parameters. The library has built-in converters, but certain circumstances
##   might prevent automatic conversion. A failure message *should* be generated when
##   compiling.
##
## Optional Submodules
## ===================
##
## nullable/json
## -------------
##
## Adds support to the standard json library.
##
## See the corresponding documentation below.
##
## nullable/object
## --------------- 
##
## Adds a macro for "wrapping" an object for use as a nullable equivalent. Only
## works with objects.
##
## For example:
##
## .. code:: nim
## 
##     import nullable/object
##
##     type
##       Person = object
##         name: nstring
##         age: nint
##
##     nullableType(Person, "nPerson")
##
##     var p: nPerson
##
##     p = nothing(nPerson)
##     p = null(nPerson)
##     p = nPerson("name": "Bob", age: null(nint))
##
## See the corresponding documentation below.
##
## Future Versions
## ===============
##
## There are two planned expansions after version 1.0.0 is released:
##
## - Allow "hint" information to be attached to a variable. This will be strictly
##   optional. With conditional compiling, no code should be added if not used.
## 
## - Adding the following types:
## 
##   - nint64 (aka "long")
## 
##   - nTime
## 
##   - nOid
## 
##   - nDecimal
##

import
  nullable/core as core,
  nullable/nint as nint,
  nullable/nstring as nstring,
  nullable/generic as generic

export
  core,
  nint,
  nstring,
  generic
