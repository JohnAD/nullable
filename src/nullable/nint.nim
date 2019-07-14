import
  strutils,
  typetraits

import
  core,
  private,
  generic

## The ``nint`` object type represents a "nullable" integer.
##
## It should behave just like the native 'int' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nint Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nint``
## if using a literal number. That is because literal integers default to
## the built in data type of ``int``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nint         # works
##     var b: nint = -4       # works
##     var c = to_nint(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "int" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nint      # works
##     var b: nint = null     # works
##     var c = to_nint(null)  # works
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
##     var a: nint = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: int, y: int)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nint.-(a: nint,
##     b: nint)[declared in src/nullable/nint.nim(161, 5)] match for: (nint, int literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an int, add the numbers, and then convert the answer back to an ``nint``, or
##
## b. convert ``2`` to a ``nint``, and then add the numbers as ``nint``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nint``. Such as:
## 
## .. code:: nim
##
##     var a: nint = 3
##     a = a + 2.nint
##

# type
#   nint* = object
#     ## The object used to represent the ``nint`` data type.
#     ##
#     ## Please note that elements are not directly accessible. You cannot
#     ## do this:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nint = 3
#     ##     echo "a = ", $a.stored_value
#     ##
#     ## that will generate a compiler error. Instead, rely on the libraries
#     ## ability to convert and adjust as needed. So, simply:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nint = 3
#     ##     echo "a = ", $a
#     ##
#     ## or possibly:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nint = 3
#     ##     var b: int = a
#     ##     echo "b = ", $b
#     ##
#     case kind: NullableKind
#     of nlkValue:
#       stored_value: int
#     of nlkNothing:
#       discard
#     of nlkNull:
#       discard
#     of nlkError:
#       errors*: seq[ExceptionClass]
#     hints: seq[Hint]

{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nint, int)

# You cannot convert a bool to a nint
# converter to_nint*(n: bool): nint = 

# You cannot convert a char to a nint
# converter to_nint*(n: char): nint = 

converter to_nint*(n: string): nint = 
  try:
    result = nint(kind: nlkValue)
    result.stored_value = parseInt(n)
  except ValueError:
    result.setError(ValueError(msg: "Could not convert string to nint."))

converter to_nint*(n: int): nint = 
  result = nint(kind: nlkValue)
  result.stored_value = n

converter to_nint*(n: float): nint = 
  result = nint(kind: nlkValue)
  result.stored_value = int(n)

# You cannot convert a nint to a bool
# converter from_nint*(n: bool): nint = 

# You cannot convert a nint to a char
# converter from_nint*(n: char): nint = 

converter from_nint_to_string*(n: nint): string = 
  result = $n

converter from_nint_to_int*(n: nint): int = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nint: Cannot convert nothing to an int.")
  of nlkNull:
    raise newException(ValueError, "nint: Cannot convert null to an int.")
  of nlkError:
    raise newException(ValueError, "nint: Cannot convert an error to an int.")

converter from_nint_to_float*(n: nint): float = 
  case n.kind:
  of nlkValue:
    result = float(n.stored_value)
  of nlkNothing:
    raise newException(ValueError, "nint: Cannot convert nothing to an int.")
  of nlkNull:
    raise newException(ValueError, "nint: Cannot convert null to an int.")
  of nlkError:
    raise newException(ValueError, "nint: Cannot convert an error to an int.")


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

proc `+`*(a: nint, b: nint): nint =
  ## Operator: ADD
  ##
  ## Represented by the plus "+" symbol, this operation adds two nint
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``nint``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(int)
  of nlkNothing:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result = nothing(int)
    of nlkValue:
      result = b
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result = a
    of nlkValue:
      result.stored_value = a.stored_value + b.stored_value
  # TODO: handle hints

proc `-`*(a: nint, b: nint): nint =
  ## Operator: SUBTRACT
  ##
  ## Represented by the minus "-" symbol, this operation subtracts two nint
  ## values from each other.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``nint``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(int)
  of nlkNothing:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result = nothing(int)
    of nlkValue:
      result.stored_value = 0 - b.stored_value
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result.stored_value = a.stored_value
    of nlkValue:
      result.stored_value = a.stored_value - b.stored_value
  # TODO: handle hints

proc `*`*(a: nint, b: nint): nint =
  ## Operator: MULTIPLY
  ##
  ## Represented by the asterisk "*" symbol, this operation multiplies two nint
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if either value is ``nothing``, the results is zero.
  ##
  ## returns a new ``nint``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(int)
  of nlkNothing:
    result = 0
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result = 0
    of nlkValue:
      result.stored_value = a.stored_value * b.stored_value
  # TODO: handle hints

# TODO: handle this when nfloat is working? Or will nfloat convert automatically?
# proc `/`*(a: nint, b: nint): nfloat =
#   ## Operator: DIVIDE
#   ##
#   ## Represented by the slash "/" symbol, this operation divides two nint
#   ## values.
#   ##
#   ## If either value is ``null`` or errored, the result is an error.
#   ## If the divisor is zero, the result is an error.
#   ##
#   ## returns a new ``nfloat``
#   var sa = deduce(a)
#   var sb = deduce(b)
#   if sa==nlkError:
#     error(result, a.error)
#   elif sb==nlkError:
#     error(result, b.error)
#   elif sa==nlkNull:
#     make_null(result)
#   elif sb==nlkNull:
#     make_null(result)
#   else:
#     result.stored_value = a.stored_value / b.stored_value
#   # TODO: handle hints

# TODO: handle this when nbool is working?
proc `<`*(a: nint, b: nint): bool =
  ## Operator: LESS-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## values.
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

# TODO: handle this when nbool is working?
proc `>`*(a: nint, b: nint): bool =
  ## Operator: GREATER-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## values.
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

# # TODO: handle this when nbool is working ?
proc `==`*(a: nint, b: nint): bool =
  ## Operator: EQUAL-TO (nint vs nint)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nint`` values.
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

proc `==`*(a: nint, b: int): bool =
  ## Operator: EQUAL-TO (nint vs int)
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

proc `==`*(a: int, b: nint): bool =
  ## Operator: EQUAL-TO (int vs nint)
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
  else:
    return a == b.stored_value

# The '@' operator has no meaning to nint

# The '~' operator has no meaning to nint

# The '&' operator has no meaning to nint

proc `div`*(dividend: nint, divisor: nint): nint =
  ## Operator: INTEGER_DIVIDE
  ##
  ## This operation divides two nint values and returns only the integer
  ## quotient.
  ##
  ## If either value is ``null`` or errored, the result is an error.
  ## If the divisor is zero, the result is an error.
  ##
  ## returns a new ``nint``
  case dividend.kind:
  of nlkValue:
    case divisor.kind:
    of nlkValue:
      if divisor.stored_value == 0:
        result.setError(DivByZeroError(msg: "Cannot divide by zero."))
      else:
        result = nint(kind: nlkValue)
        result.stored_value = dividend.stored_value div divisor.stored_value
    else:
      result.setError(ValueError(msg: "Cannot divide by nothing, null, or error."))
  else:
    result.setError(ValueError(msg: "Nothing, null, or error cannot be divided by."))
  # TODO: handle hints

# BUGGY, but don't know why yet
# proc `%`*(dividend: nint, divisor: nint): nint =
#   ## Operator: MODULO
#   ##
#   ## Represented by the percent "%" symbol, this operation divides two nint
#   ## values and returns the remainder
#   ##
#   ## If either value is ``null`` or errored, the result is an error.
#   ## If the divisor is zero, the result is an error.
#   ##
#   ## returns a new ``nint``
#   var sn = deduce(dividend)
#   var sd = deduce(divisor)
#   if sn==nlkError:
#     error(result, dividend.error)
#   elif sd==nlkError:
#     error(result, divisor.error)
#   elif sn==nlkNull:
#     make_null(result)
#   elif sd==nlkNull:
#     make_null(result)
#   else:
#     echo "here"
#     let x: int = dividend.stored_value % divisor.stored_value
#     result.stored_value = x
#   # TODO: handle hints

# The '!' operator has no meaning to nint

# The '?' operator has no meaning to nint

# The '^' operator has no meaning to nint

# The '.' operator has no meaning to nint

# The '|' operator has no meaning to nint

# The 'and' operator has no meaning to nint

# The 'not' operator has no meaning to nint
