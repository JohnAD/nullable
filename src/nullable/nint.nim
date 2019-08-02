import
  strutils,
  typetraits

import
  core,
  private,
  generic

## REDO DOCS
##
##


{.hint[XDeclaredButNotUsed]:off.}

converter to_nint*(n: string): N[int] = 
  try:
    result.set parseInt(n)
  except ValueError:
    result.setError(ValueError(msg: "Could not convert string to N[int]."))

# converter to_nint*(n: int): N[int] = 
#   result.set n

converter to_nint*(n: float): N[int] = 
  result.set int(n)

converter from_nint_to_string*(n: N[int]): string = 
  result = $n

# converter from_nint_to_int*(n: N[int]): int = 
#   case n.kind:
#   of nlkValue:
#     result = n.get()
#   of nlkNothing:
#     raise newException(ValueError, "N[int]: Cannot convert nothing to an int.")
#   of nlkNull:
#     raise newException(ValueError, "N[int]: Cannot convert null to an int.")
#   of nlkError:
#     raise newException(ValueError, "N[int]: Cannot convert an error to an int.")

converter from_nint_to_float*(n: N[int]): float = 
  case n.kind:
  of nlkValue:
    result = float(n.get())
  of nlkNothing:
    raise newException(ValueError, "N[int]: Cannot convert nothing to an int.")
  of nlkNull:
    raise newException(ValueError, "N[int]: Cannot convert null to an int.")
  of nlkError:
    raise newException(ValueError, "N[int]: Cannot convert an error to an int.")


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

proc `+`*(a: N[int], b: N[int]): N[int] =
  ## Operator: ADD
  ##
  ## Represented by the plus "+" symbol, this operation adds two N[int]
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``N[int]``
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
      result.set a.get() + b.get()
  # TODO: handle hints

proc `-`*(a: N[int], b: N[int]): N[int] =
  ## Operator: SUBTRACT
  ##
  ## Represented by the minus "-" symbol, this operation subtracts two N[int]
  ## values from each other.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``N[int]``
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
      result.set 0 - b.get()
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(int)
    of nlkNothing:
      result.set a.get()
    of nlkValue:
      result.set a.get() - b.get()
  # TODO: handle hints

proc `*`*(a: N[int], b: N[int]): N[int] =
  ## Operator: MULTIPLY
  ##
  ## Represented by the asterisk "*" symbol, this operation multiplies two N[int]
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if either value is ``nothing``, the results is zero.
  ##
  ## returns a new ``N[int]``
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
      result.set a.get() * b.get()
  # TODO: handle hints

# TODO: handle this when nfloat is working? Or will nfloat convert automatically?
# proc `/`*(a: N[int], b: N[int]): nfloat =
#   ## Operator: DIVIDE
#   ##
#   ## Represented by the slash "/" symbol, this operation divides two N[int]
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
#     result.set a.get() / b.get()
#   # TODO: handle hints

# TODO: handle this when nbool is working?
proc `<`*(a: N[int], b: N[int]): bool =
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
    return a.get() < b.get()

# TODO: handle this when nbool is working?
proc `>`*(a: N[int], b: N[int]): bool =
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
    return a.get() > b.get()

# # TODO: handle this when nbool is working ?
proc `==`*(a: N[int], b: N[int]): bool =
  ## Operator: EQUAL-TO (N[int] vs N[int])
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``N[int]`` values.
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
    return a.get() == b.get()

proc `==`*(a: N[int], b: int): bool =
  ## Operator: EQUAL-TO (N[int] vs int)
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
    return a.get() == b

proc `==`*(a: int, b: N[int]): bool =
  ## Operator: EQUAL-TO (int vs N[int])
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
    return a == b.get()

# The '@' operator has no meaning to N[int]

# The '~' operator has no meaning to N[int]

# The '&' operator has no meaning to N[int]

proc `div`*(dividend: N[int], divisor: N[int]): N[int] =
  ## Operator: INTEGER_DIVIDE
  ##
  ## This operation divides two N[int] values and returns only the integer
  ## quotient.
  ##
  ## If either value is ``null`` or errored, the result is an error.
  ## If the divisor is zero, the result is an error.
  ##
  ## returns a new ``N[int]``
  case dividend.kind:
  of nlkValue:
    case divisor.kind:
    of nlkValue:
      if divisor.get() == 0:
        result.setError(DivByZeroError(msg: "Cannot divide by zero."))
      else:
        result = N[int](kind: nlkValue)
        result.set dividend.get() div divisor.get()
    else:
      result.setError(ValueError(msg: "Cannot divide by nothing, null, or error."))
  else:
    result.setError(ValueError(msg: "Nothing, null, or error cannot be divided by."))
  # TODO: handle hints

# BUGGY, but don't know why yet
# proc `%`*(dividend: N[int], divisor: N[int]): N[int] =
#   ## Operator: MODULO
#   ##
#   ## Represented by the percent "%" symbol, this operation divides two N[int]
#   ## values and returns the remainder
#   ##
#   ## If either value is ``null`` or errored, the result is an error.
#   ## If the divisor is zero, the result is an error.
#   ##
#   ## returns a new ``N[int]``
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
#     let x: int = dividend.get() % divisor.get()
#     result.set x
#   # TODO: handle hints

# The '!' operator has no meaning to N[int]

# The '?' operator has no meaning to N[int]

# The '^' operator has no meaning to N[int]

# The '.' operator has no meaning to N[int]

# The '|' operator has no meaning to N[int]

# The 'and' operator has no meaning to N[int]

# The 'not' operator has no meaning to N[int]
