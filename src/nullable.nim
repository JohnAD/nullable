## A nim type that expands on the original idea of the Option[T] ``options``
## library for greater flexibility and logging.
##
## Introduction
## ============
##
## Nim has a standard library called ``options`` that provides a type wrapper 
## ``Option[T]`` which allows the easy creation types than can either be ``none``
## or have a value. In many ways, ``Option[T]`` types allow procedures and variables
## to have almost "dynamic" behavior while staying true to the enforcement of a
## statically typed language.
##
## Unfortunately, for those accustomed to the open behavior of a dynamic language,
## there are still some key scenarios that it cannot cover. Specifically:
##
## * There is no means to set the variable to an "Error" message.
## * There is no way to "tag" extra information (even when not an error) to 
##   the variable, such as messaging details.
## * The defifinition of "none" is not distincly defined. Nor is there a way
##   to indicate whether a variable is currently unknown or is a non-value.
##   (In JSON, BSON, and SQL these are distinctly different things.)
##
## Nullable, using the ``N[T]`` wrapper was designed to solve these problems.
##
## As a bonus, ``N[T]`` also allows:
##
## * direct assignment conversion, thus avoiding the need for the ``some`` function.
## * special handling for ``N[int]`` and ``N[float]``, giving them conversion,
##   arithmetic, and comparitive functions
## * special handling for ``N[string]``, ``N[Oid]``, ``N[bool]``, ``N[char]``, and
##   ``N[Time]``, giving them extra conversion functions
##
## Basic Use and Assignment
## ========================
##
## TODO
##
## Assigning Errors
## ================
##
## TODO
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
##     assert( nothing(N[int]) == nothing(N[int]) )
##     assert( null(N[int]) != null(N[int]) )
##
##     assert( null(N[int]).isNull )
##
## An "unknown" value (``null``) cannot be assumed to be the same as another
## "unknown" value. This is in keeping with the term's meaning in databases. On
## the other hand, ``nothing`` does equal ``nothing``. To determine if a variable
## is null, use the ``isNull`` function.
##
## .. code:: nim
## 
##     assert( (nothing(N[int]) + 4).isError )
##     assert( (null(N[int]) + 4) == null(N[int]) )
##
##     var mySeq: seq[N[int]] = @[-9, null(N[int]), 3]
##     assert( count(mySeq) == 2 )
##     assert( len(mySeq) == 3 )
##     assert( sum(mySeq) == -6 )
##
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
##       "windturbine_category": nothing(N[string]),
##       "age": null(N[string]),
##       "other": @["J", null(N[int]), 4, nothing(N[int]), 3.2]
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
## nullable/marshall
## -----------------
##
## Adds support to the standard marshall library.
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
##   - nDecimal
##

import
  nullable/core as core,
  # nullable/nbool as nbool,
  # nullable/nchar as nchar,
  # nullable/nfloat as nfloat,
  nullable/nint as nint,
  # nullable/noid as noid,
  # nullable/nstring as nstring,
  # nullable/ntime as ntime,
  nullable/generic as generic

export
  core,
  # nbool,
  # nchar,
  # nfloat,
  nint,
  # noid,
  # nstring,
  # ntime,
  generic
