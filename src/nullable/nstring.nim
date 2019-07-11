import
  strutils,
  typetraits

import
  core,
  private,
  generic

## The ``nstring`` object type represents a "nullable" string.
##
## It should behave just like the native 'string' type in most instances; except
## where the possible null, nothing, or Error states are involved.
##
## Further details are in the "nstring Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nstring``
## if using a literal string. That is because literal strings default to
## the built in data type of ``string``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = "hello".nstring      # works
##     var b: nstring = "hello"     # works
##     var c = to_nstring("hello")  # works
##     var d = c                    # also works
##     a = "goodbye"                # still works
##
##     var e = "hello"              # does not work; "e" will be an "string" instead
##
## and, of course, you can assign the value to ``null`` or ``nothing``, but again,
## you must be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
## 
##     var a = null(string)           # works
##     var b: nstring = null(string)  # works
##     var c = null(nstring)          # also works oddly enough
##
## The error state for a ``nstring`` is set explicitly with the ``setError`` function.
##
## .. code:: nim
##
##     import nullable
## 
##     var a: nstring
##     a.setError(ValueError(msg: "something went wrong"))
## 

# type
#   nstring* = object
#     ## The object used to represent the ``nstring`` data type.
#     ##
#     ## Please note that elements are not directly accessible. You cannot
#     ## do this:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nstring = "hello"
#     ##     echo "a = ", a.stored_value
#     ##
#     ## that will generate a compiler error. Instead, rely on the libraries
#     ## ability to convert and adjust as needed. So, simply:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nstring = "hello"
#     ##     echo "a = ", a
#     ##
#     ## or possibly:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nstring = "hello"
#     ##     var b: string = a
#     ##     echo "b = ", b
#     ##
#     ##     echo "a = ", a.get()  # also works. ``get`` returns a string
#     ##
#     case kind: NullableKind
#     of nlkValue:
#       stored_value: string
#     of nlkNothing:
#       discard
#     of nlkNull:
#       discard
#     of nlkError:
#       errors*: seq[ExceptionClass]
#     hints: seq[Hint]

{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nstring, string)

# You cannot convert a bool to a nstring
# converter to_nstring*(n: bool): nstring = 

# You cannot convert a char to a nstring
# converter to_nstring*(n: char): nstring = 

converter to_nstring*(n: string): nstring = 
  result = nstring(kind: nlkValue)
  result.stored_value = n

# You cannot convert a int to a nstring
# converter to_nstring*(n: int): nstring = 

# You cannot convert a float to a nstring
# converter to_nstring*(n: float): nstring = 

converter from_nstring_to_string*(n: nstring): string = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nstring: Cannot convert nothing to a string.")
  of nlkNull:
    raise newException(ValueError, "nstring: Cannot convert null to a string.")
  of nlkError:
    raise newException(ValueError, "nstring: Cannot convert an error to a string.")

proc make_nothing(n: var nstring) =
  ## Force the nstring into a null state
  n = nstring(kind: nlkNull, hints: n.hints)

proc make_null(n: var nstring) =
  ## Force the nstring into a null state
  n = nstring(kind: nlkNull, hints: n.hints)


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

# The '+' operator has no meaning to nstring. consider using `&` perhaps

# The '-' operator has no meaning to nstring

# The `*` operator has no meaning to nstring

# The `/` operator has no meaning to nstring

proc `<`*(a: nstring, b: nstring): bool =
  ## Operator: LESS-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## strings for alphabetical order.
  ##
  ## If a is ``Nothing``, and b has a value, then the results is always true.
  ## If either value is ``null`` or ``error``, the result is false
  if a.kind == nlkNothing:
    if b.kind == nlkValue:
      return true
  if a.kind != b.kind:
    return false
  case a.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return false
  of nlkValue:
    return a.stored_value < b.stored_value

proc `>`*(a: nstring, b: nstring): bool =
  ## Operator: GREATER-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## strings for alphaetical order.
  ##
  ## If a has a value and b is ``Nothing``, then the result is always true.
  ## If either value is ``null`` or ``error``, the result is false.
  if b.kind == nlkNothing:
    if a.kind == nlkValue:
      return true
  if a.kind != b.kind:
    return false
  case a.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return false
  of nlkValue:
    return a.stored_value > b.stored_value

proc `==`*(a: nstring, b: nstring): bool =
  ## Operator: EQUAL-TO (nstring vs nstring)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nstring`` values.
  ##
  ## If either value is null, then it returns false.
  ## If either value is ``error``, the result is false.
  ## If both are nothing, then true. If only one is nothing, then false.
  ## 
  ## Very specifically: nothing(string) != "".nstring
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

proc `==`*(a: nstring, b: string): bool =
  ## Operator: EQUAL-TO (nstring vs nstring)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nstring`` values.
  ##
  ## If a is null, then it returns false.
  ## If a is ``error``, the result is false.
  ## If a is nothing, then false.
  case a.kind:
  of nlkError:
    return false
  of nlkNull:
    return false
  of nlkNothing:
    return false
  of nlkValue:
    return a.stored_value == b

# The '@' operator has no meaning to nstring

# The '~' operator has no meaning to nstring

proc `&`*(a: nstring, b: nstring): nstring =
  ## Operator: AND
  ##
  ## As always, "error override null" and "null overrides value (or nothing)"
  ## If either a or b are error, the result is the cumulative error
  ## If either a or b are null, the result is null
  ## If either a or b are nothing, it is treated as a "". If both are nothing,
  ##   then the result is nothing.
  case a.kind:
  of nlkError:
    case a.kind:
    of nlkError:
      result = a
      result.setError(b)
    of nlkNull, nlkNothing, nlkValue:
      result = a
  of nlkNull:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull, nlkNothing, nlkValue:
      result = a
  of nlkNothing:
    case b.kind:
    of nlkError, nlkNull:
      result = b
    of nlkNothing:
      result = a
    of nlkValue:
      result = b
  of nlkValue:
    case b.kind:
    of nlkError, nlkNull:
      result = b
    of nlkNothing:
      result = a
    of nlkValue:
      result = a
      result.stored_value &= b.stored_value

# The `div` operator has no meaning to nstring

# The `%` operator has no meaning to nstring

# The '!' operator has no meaning to nstring

# The '?' operator has no meaning to nstring

# The '^' operator has no meaning to nstring

# The '.' operator has no meaning to nstring

# The '|' operator has no meaning to nstring

# The 'and' operator has no meaning to nstring

# The 'not' operator has no meaning to nstring
