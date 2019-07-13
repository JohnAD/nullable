import
  strutils,
  typetraits

import
  core,
  private,
  generic

## The ``nfloat`` object type represents a "nullable" float.
##
## It should behave just like the native 'float' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nfloat Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nfloat``
## if using a literal number. That is because literal floats default to
## the built in data type of ``float``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nfloat         # works
##     var b: nfloat = -4       # works
##     var c = to_nfloat(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "float" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nfloat      # works
##     var b: nfloat = null     # works
##     var c = to_nfloat(null)  # works
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
##     var a: nfloat = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: float, y: float)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nfloat.-(a: nfloat,
##     b: nfloat)[declared in src/nullable/nfloat.nim(161, 5)] match for: (nfloat, float literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an float, add the numbers, and then convert the answer back to an ``nfloat``, or
##
## b. convert ``2`` to a ``nfloat``, and then add the numbers as ``nfloat``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nfloat``. Such as:
## 
## .. code:: nim
##
##     var a: nfloat = 3
##     a = a + 2.nfloat
##

# type
#   nfloat* = object
#     ## The object used to represent the ``nfloat`` data type.
#     ##
#     ## Please note that elements are not directly accessible. You cannot
#     ## do this:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nfloat = 3
#     ##     echo "a = ", $a.stored_value
#     ##
#     ## that will generate a compiler error. Instead, rely on the libraries
#     ## ability to convert and adjust as needed. So, simply:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nfloat = 3
#     ##     echo "a = ", $a
#     ##
#     ## or possibly:
#     ##
#     ## .. code:: nim
#     ##
#     ##     var a: nfloat = 3
#     ##     var b: float = a
#     ##     echo "b = ", $b
#     ##
#     case kind: NullableKind
#     of nlkValue:
#       stored_value: float
#     of nlkNothing:
#       discard
#     of nlkNull:
#       discard
#     of nlkError:
#       errors*: seq[ExceptionClass]
#     hints: seq[Hint]

{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nfloat, float)

# You cannot convert a bool to a nfloat
# converter to_nfloat*(n: bool): nfloat = 

# You cannot convert a char to a nfloat
# converter to_nfloat*(n: char): nfloat = 

converter to_nfloat*(n: string): nfloat = 
  try:
    result = nfloat(kind: nlkValue)
    result.stored_value = parseFloat(n)
  except ValueError:
    result.setError(ValueError(msg: "Could not convert string to nfloat."))

converter to_nfloat*(n: float): nfloat = 
  result = nfloat(kind: nlkValue)
  result.stored_value = n

converter to_nfloat*(n: int): nfloat = 
  result = nfloat(kind: nlkValue)
  result.stored_value = float(n)

# You cannot convert a nfloat to a bool
# converter from_nfloat*(n: bool): nfloat = 

# You cannot convert a nfloat to a char
# converter from_nfloat*(n: char): nfloat = 

converter from_nfloat_to_string*(n: nfloat): string = 
  result = $n

converter from_nfloat_to_float*(n: nfloat): float = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nfloat: Cannot convert nothing to an float.")
  of nlkNull:
    raise newException(ValueError, "nfloat: Cannot convert null to an float.")
  of nlkError:
    raise newException(ValueError, "nfloat: Cannot convert an error to an float.")

converter from_nfloat_to_int*(n: nfloat): int = 
  case n.kind:
  of nlkValue:
    result = int(n.stored_value)
  of nlkNothing:
    raise newException(ValueError, "nfloat: Cannot convert nothing to an float.")
  of nlkNull:
    raise newException(ValueError, "nfloat: Cannot convert null to an float.")
  of nlkError:
    raise newException(ValueError, "nfloat: Cannot convert an error to an float.")

proc make_nothing(n: var nfloat) =
  ## Force the nfloat into a null state
  n = nfloat(kind: nlkNull, hints: n.hints)

proc make_null(n: var nfloat) =
  ## Force the nfloat into a null state
  n = nfloat(kind: nlkNull, hints: n.hints)


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

proc `+`*(a: nfloat, b: nfloat): nfloat =
  ## Operator: ADD
  ##
  ## Represented by the plus "+" symbol, this operation adds two nfloat
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``nfloat``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(float)
  of nlkNothing:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(float)
    of nlkNothing:
      result = nothing(float)
    of nlkValue:
      result = b
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(float)
    of nlkNothing:
      result = a
    of nlkValue:
      result.stored_value = a.stored_value + b.stored_value
  # TODO: handle hints

proc `-`*(a: nfloat, b: nfloat): nfloat =
  ## Operator: SUBTRACT
  ##
  ## Represented by the minus "-" symbol, this operation subtracts two nfloat
  ## values from each other.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if one value is ``nothing``, the nothing is treated as zero
  ## if both values are nothing, the result is nothing
  ##
  ## returns a new ``nfloat``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(float)
  of nlkNothing:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(float)
    of nlkNothing:
      result = nothing(float)
    of nlkValue:
      result.stored_value = 0 - b.stored_value
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(float)
    of nlkNothing:
      result.stored_value = a.stored_value
    of nlkValue:
      result.stored_value = a.stored_value - b.stored_value
  # TODO: handle hints

proc `*`*(a: nfloat, b: nfloat): nfloat =
  ## Operator: MULTIPLY
  ##
  ## Represented by the asterisk "*" symbol, this operation multiplies two nfloat
  ## values together.
  ##
  ## If either value is errored, the result is an error.
  ## If either value is null, the result is null.
  ## if either value is ``nothing``, the results is zero.
  ##
  ## returns a new ``nfloat``
  case a.kind:
  of nlkError:
    result = a
  of nlkNull:
    result = null(float)
  of nlkNothing:
    result = 0
  of nlkValue:
    case b.kind:
    of nlkError:
      result = b
    of nlkNull:
      result = null(float)
    of nlkNothing:
      result = 0
    of nlkValue:
      result.stored_value = a.stored_value * b.stored_value
  # TODO: handle hints

# TODO: handle this when nfloat is working? Or will nfloat convert automatically?
# proc `/`*(a: nfloat, b: nfloat): nfloat =
#   ## Operator: DIVIDE
#   ##
#   ## Represented by the slash "/" symbol, this operation divides two nfloat
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
proc `<`*(a: nfloat, b: nfloat): bool =
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
proc `>`*(a: nfloat, b: nfloat): bool =
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
proc `==`*(a: nfloat, b: nfloat): bool =
  ## Operator: EQUAL-TO (nfloat vs nfloat)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nfloat`` values.
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

proc `==`*(a: nfloat, b: float): bool =
  ## Operator: EQUAL-TO (nfloat vs float)
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

proc `==`*(a: float, b: nfloat): bool =
  ## Operator: EQUAL-TO (float vs nfloat)
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

# The '@' operator has no meaning to nfloat

# The '~' operator has no meaning to nfloat

# The '&' operator has no meaning to nfloat

proc `div`*(dividend: nfloat, divisor: nfloat): nfloat =
  ## Operator: INTEGER_DIVIDE
  ##
  ## This operation divides two nfloat values and returns only the float
  ## quotient.
  ##
  ## If either value is ``null`` or errored, the result is an error.
  ## If the divisor is zero, the result is an error.
  ##
  ## returns a new ``nfloat``
  case dividend.kind:
  of nlkValue:
    case divisor.kind:
    of nlkValue:
      if divisor.stored_value == 0:
        result.setError(DivByZeroError(msg: "Cannot divide by zero."))
      else:
        result = nfloat(kind: nlkValue)
        result.stored_value = dividend.stored_value div divisor.stored_value
    else:
      result.setError(ValueError(msg: "Cannot divide by nothing, null, or error."))
  else:
    result.setError(ValueError(msg: "Nothing, null, or error cannot be divided by."))
  # TODO: handle hints

# BUGGY, but don't know why yet
# proc `%`*(dividend: nfloat, divisor: nfloat): nfloat =
#   ## Operator: MODULO
#   ##
#   ## Represented by the percent "%" symbol, this operation divides two nfloat
#   ## values and returns the remainder
#   ##
#   ## If either value is ``null`` or errored, the result is an error.
#   ## If the divisor is zero, the result is an error.
#   ##
#   ## returns a new ``nfloat``
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

# The '!' operator has no meaning to nfloat

# The '?' operator has no meaning to nfloat

# The '^' operator has no meaning to nfloat

# The '.' operator has no meaning to nfloat

# The '|' operator has no meaning to nfloat

# The 'and' operator has no meaning to nfloat

# The 'not' operator has no meaning to nfloat
