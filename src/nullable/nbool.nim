import
  strutils,
  typetraits

import
  core,
  private,
  generic

## The ``nbool`` object type represents a "nullable" bool.
##
## It should behave just like the native 'bool' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nbool Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nbool``
## if using a literal number. That is because literal bools default to
## the built in data type of ``bool``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nbool         # works
##     var b: nbool = -4       # works
##     var c = to_nbool(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "bool" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nbool      # works
##     var b: nbool = null     # works
##     var c = to_nbool(null)  # works
##     var d = c              # also works
##     a = null               # still works
##
##     var e = null           # does NOT work; "e" will be unusable
##
## Handling an "Ambiguous Call" Compiler Error
## -------------------------------------------
##
## You can *sometimes* encounter an "ambiguous call" error at compile-time. For example:
##
## .. code:: nim
##
##     import nullable
##     var a: nbool = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: bool, y: bool)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nbool.-(a: nbool,
##     b: nbool)[declared in src/nullable/nbool.nim(161, 5)] match for: (nbool, bool literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an bool, add the numbers, and then convert the answer back to an ``nbool``, or
##
## b. convert ``2`` to a ``nbool``, and then add the numbers as ``nbool``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nbool``. Such as:
## 
## .. code:: nim
##
##     var a: nbool = 3
##     a = a + 2.nbool
##

# type
#   nbool* = object
#     ## The object used to represent the ``nbool`` data type.
#     ##
#     ## Please note that elements are not directly accessible. You cannot
#     ## do this:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nbool = 3
#     ##     echo "a = ", $a.stored_value
#     ##
#     ## that will generate a compiler error. Instead, rely on the libraries
#     ## ability to convert and adjust as needed. So, simply:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nbool = 3
#     ##     echo "a = ", $a
#     ##
#     ## or possibly:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nbool = 3
#     ##     var b: bool = a
#     ##     echo "b = ", $b
#     ##
#     case kind: NullableKind
#     of nlkValue:
#       stored_value: bool
#     of nlkNothing:
#       discard
#     of nlkNull:
#       discard
#     of nlkError:
#       errors*: seq[ExceptionClass]
#     hints: seq[Hint]

{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nbool, bool)

converter to_nbool*(n: bool): nbool = 
  result = nbool(kind: nlkValue)
  result.stored_value = n

# You cannot convert a string to a nbool
# converter to_nbool*(n: char): nbool = 

# You cannot convert a float to a nbool
# converter to_nbool*(n: char): nbool = 

# You cannot convert a int to a nbool
# converter to_nbool*(n: char): nbool = 

converter from_nbool_to_bool*(n: nbool): bool = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nbool: Cannot convert nothing to an bool.")
  of nlkNull:
    raise newException(ValueError, "nbool: Cannot convert null to an bool.")
  of nlkError:
    raise newException(ValueError, "nbool: Cannot convert an error to an bool.")

proc make_nothing(n: var nbool) =
  ## Force the nbool into a null state
  n = nbool(kind: nlkNull, hints: n.hints)

proc make_null(n: var nbool) =
  ## Force the nbool into a null state
  n = nbool(kind: nlkNull, hints: n.hints)


# ###########################################
#
# OPERATORS
#
# +, -, *, /, <, >, ==, @, ~, &, div, %, !, ?, ^, ., |, and, not
#
# the = and $ operator procs are declared earlier
#
# ###########################################

# TODO: or xor shl shr div mod in notin is isnot of.

# The '+' operator has no meaning to nbool

# The '-' operator has no meaning to nbool

# The '*' operator has no meaning to nbool

# The '/' operator has no meaning to nbool

# The '<' operator has no meaning to nbool

# The '>' operator has no meaning to nbool

proc `==`*(a: nbool, b: nbool): bool =
  ## Operator: EQUAL-TO (nbool vs nbool)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nbool`` values.
  ##
  ## If either value is null, then it returns false.
  ## If either value is ``error``, the result is false.
  ## If both are nothing, then true. If only one is nothing, then false.
  if a.kind != b.kind:
    return false
  case a.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return true
  of nlkValue:
    return a.stored_value == b.stored_value

proc `==`*(a: nbool, b: bool): bool =
  ## Operator: EQUAL-TO (nbool vs bool)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## values.
  case a.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return false
  else:
    return a.stored_value == b

proc `==`*(a: bool, b: nbool): bool =
  ## Operator: EQUAL-TO (bool vs nbool)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## values.
  case b.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return false
  of nlkValue:
    return a == b.stored_value

# The '@' operator has no meaning to nbool

# The '~' operator has no meaning to nbool

# The '&' operator has no meaning to nbool

# The 'div' operator has no meaning to nbool

# The '%' operator has no meaning to nbool

# The '!' operator has no meaning to nbool

proc `!`*(a: nbool): bool =
  ## Operator: NOT (bool)
  ##
  case a.kind:
  of nlkError:
    raise newException(ValueError, "nbool: Cannot convert error to a bool.")
  of nlkNull:
    raise newException(ValueError, "nbool: Cannot convert null to a bool.")
  of nlkNothing:
    raise newException(ValueError, "nbool: Cannot convert nothing to a bool.")
  of nlkValue:
    return !a.stored_value

# The '?' operator has no meaning to nbool

# The '^' operator has no meaning to nbool

# The '.' operator has no meaning to nbool

# The '|' operator has no meaning to nbool

# The 'and' operator has no meaning to nbool

# The 'not' operator has no meaning to nbool
