import
  strutils,
  typetraits

import core

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

type
  nint* = object
    ## The object used to represent the ``nint`` data type.
    ##
    ## Please note that elements are not directly accessible. You cannot
    ## do this:
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = 3
    ##     echo "a = ", $a.stored_value
    ##
    ## that will generate a compiler error. Instead, rely on the libraries
    ## ability to convert and adjust as needed. So, simply:
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = 3
    ##     echo "a = ", $a
    ##
    ## or possibly:
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = 3
    ##     var b: int = a
    ##     echo "b = ", $b
    ##
    stored_value: int            # defaults to 0
    null: bool                   # defaults to false (not null)
    error: ExceptionClass        # defaults to empty
    hints: seq[Hint]             # defaults to empty

# "error" overrides "null" which overrides "real value"
proc deduce(n: nint): NState =
  if n.error.flag:
    return state_errored
  elif n.null == true:
    return state_nulled
  return state_valued


{.hint[XDeclaredButNotUsed]:off.}

proc `$`*(n: nint): string = 
  result = "unknown"
  var s = deduce(n)
  if s==state_errored:
    result = $n.error
  elif s==state_nulled:
    result = "null"
  else:
    result = $n.stored_value

proc `=`*(n: var nint, src: nint) = 
  n.stored_value = src.stored_value
  n.null = src.null
  n.error = src.error
  n.hints = src.hints

converter to_nint*(n: NullClass): nint =
  result.null = true


converter to_nint*(e: IOError): nint =
  result.error.msg = e.msg
  result.error.flag = true
  result.error.exception_type = name(type(e))

converter to_nint*(e: OSError): nint =
  result.error.msg = e.msg
  result.error.flag = true
  result.error.exception_type = name(type(e))

converter to_nint*(e: ResourceExhaustedError): nint =
  result.error.msg = e.msg
  result.error.flag = true
  result.error.exception_type = name(type(e))

converter to_nint*(e: ValueError): nint =
  result.error.msg = e.msg
  result.error.flag = true
  result.error.exception_type = name(type(e))


# You cannot convert a bool to a nint
# converter to_nint*(n: bool): nint = 

# You cannot convert a char to a nint
# converter to_nint*(n: char): nint = 

converter to_nint*(n: string): nint = 
  try:
    result.stored_value = parseInt(n)
    result.null = false
    result.error = ExceptionClass()
    result.hints = @[]
  except ValueError:
    result = ValueError(msg: "Could not convert string to nint.")

converter to_nint*(n: int): nint = 
  result.stored_value = n
  result.null = false
  result.error = ExceptionClass()
  result.hints = @[]

converter to_nint*(n: float): nint = 
  result.stored_value = int(n)
  result.null = false
  result.error = ExceptionClass()
  result.hints = @[]

# You cannot convert a nint to a bool
# converter from_nint*(n: bool): nint = 

# You cannot convert a nint to a char
# converter from_nint*(n: char): nint = 

converter from_nint_to_string*(n: nint): string = 
  result = $n

converter from_nint_to_int*(n: nint): int = 
  var s = deduce(n)
  if s == state_nulled:
    raise newException(ValueError, "Cannot convert a null to an int.")
  elif s == state_errored:
    raise newException(ValueError, "Cannot convert an error to an int.")
  result = n.stored_value

converter from_nint_to_float*(n: nint): float = 
  result = float(n.stored_value)


proc make_null(n: var nint) =
  ## Force the nint into a null state
  n.stored_value = 0
  n.null = true
  n.error = ExceptionClass()

proc has_error*(n: nint): bool =
  ## Check to see if n has an error associated with it.
  ##
  ## .. code:: nim
  ##
  ##     var a: nint = ValueError("Too small.")
  ##     if a.has_error:
  ##       echo "Error found: " & $a
  ##
  var s = deduce(n)
  return s==state_errored

proc is_null*(n: nint): bool =
  ## Check to see if n is unknown (a null).
  ##
  ## .. code:: nim
  ##
  ##     var a: nint = null
  ##     if a.is_null:
  ##       echo "It is null."
  ##
  var s = deduce(n)
  return s==state_nulled

proc is_good*(n: nint): bool =
  ## Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
  ## have an error. A newly declared ``nint`` defaults to 0 (zero) and is good.
  ##
  ## .. code:: nim
  ##
  ##     var a: nint = 5
  ##     if a.is_good:
  ##       echo "a = " & $a
  ##
  var s = deduce(n)
  return s==state_valued

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
  ## If either value is ``null`` or errored, the result is an error.
  ##
  ## returns a new ``nint``
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    result = a
  elif sb==state_errored:
    result = b
  elif sa==state_nulled:
    result = null
  elif sb==state_nulled:
    result = null
  else:
    result.stored_value = a.stored_value + b.stored_value
  # TODO: handle hints

proc `-`*(a: nint, b: nint): nint =
  ## Operator: SUBTRACT
  ##
  ## Represented by the minus "-" symbol, this operation subtracts two nint
  ## values from each other.
  ##
  ## If either value is ``null`` or errored, the result is an error.
  ##
  ## returns a new ``nint``
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    result = a
  elif sb==state_errored:
    result = b
  elif sa==state_nulled:
    result = null
  elif sb==state_nulled:
    result = null
  else:
    result.stored_value = a.stored_value - b.stored_value
  # TODO: handle hints

proc `*`*(a: nint, b: nint): nint =
  ## Operator: MULTIPLY
  ##
  ## Represented by the asterisk "*" symbol, this operation multiplies two nint
  ## values together.
  ##
  ## If either value is ``null`` or errored, the result is an error.
  ##
  ## returns a new ``nint``
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    result = a
  elif sb==state_errored:
    result = b
  elif sa==state_nulled:
    result = null
  elif sb==state_nulled:
    result = null
  else:
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
#   if sa==state_errored:
#     error(result, a.error)
#   elif sb==state_errored:
#     error(result, b.error)
#   elif sa==state_nulled:
#     make_null(result)
#   elif sb==state_nulled:
#     make_null(result)
#   else:
#     result.stored_value = a.stored_value / b.stored_value
#   # TODO: handle hints

# TODO: handle this when nbool is working?
proc `<`*(a: nint, b: nint): bool =
  ## Operator: LESS-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## ``nint`` values.
  ##
  ## If either value is ``null``, the result is false
  ## If either value is ``error``, the result is false.
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    return false
  elif sb==state_errored:
    return false
  elif sa==state_nulled:
    return false
  elif sb==state_nulled:
    return false
  else:
    return a.stored_value < b.stored_value

# TODO: handle this when nbool is working?
proc `>`*(a: nint, b: nint): bool =
  ## Operator: GREATER-THAN
  ##
  ## Represented by the angle-bracket "<" symbol, this operation compares two
  ## ``nint`` values.
  ##
  ## If either value is ``null``, the result is false.
  ## If either value is ``error``, the result is false.
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    return false
  elif sb==state_errored:
    return false
  elif sa==state_nulled:
    return false
  elif sb==state_nulled:
    return false
  else:
    return a.stored_value > b.stored_value

# # TODO: handle this when nbool is working ?
proc `==`*(a: nint, b: nint): bool =
  ## Operator: EQUAL-TO (nint vs nint)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nint`` values.
  ##
  ## If both values are ``null``, the result is true. If only one, then false.
  ## If either value is ``error``, the result is false.
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    return false
  elif sb==state_errored:
    return false
  elif (sa==state_nulled) or (sb==state_nulled):
    return false
  else:
    return a.stored_value == b.stored_value

proc `==`*(a: nint, b: int): bool =
  ## Operator: EQUAL-TO (nint vs int)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nint`` values.
  ##
  ## If both values are ``null``, the result is true. If only one, then false.
  ## If either value is ``error``, the result is false.
  var sa = deduce(a)
  if sa==state_errored:
    return false
  elif sa==state_nulled:
    return false
  else:
    return a.stored_value == b

proc `==`*(a: int, b: nint): bool =
  ## Operator: EQUAL-TO (int vs nint)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nint`` values.
  ##
  ## If both values are ``null``, the result is true. If only one, then false.
  ## If either value is ``error``, the result is false.
  var sb = deduce(b)
  if sb==state_errored:
    return false
  elif sb==state_nulled:
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
  var sn = deduce(dividend)
  var sd = deduce(divisor)
  if sn==state_errored:
    result = dividend
  elif sd==state_errored:
    result = divisor
  elif sn==state_nulled:
    result = null
  elif sd==state_nulled:
    result = null
  else:
    result.stored_value = dividend.stored_value div divisor.stored_value
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
#   if sn==state_errored:
#     error(result, dividend.error)
#   elif sd==state_errored:
#     error(result, divisor.error)
#   elif sn==state_nulled:
#     make_null(result)
#   elif sd==state_nulled:
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
