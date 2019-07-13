import
  strutils,
  typetraits,
  times

import
  core,
  private,
  generic

export
  times

## The ``nTime`` object type represents a "nullable" Time.
##
## It should behave just like the native 'Time' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nTime Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nTime``
## if using a literal number. That is because literal Times default to
## the built in data type of ``Time``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nTime         # works
##     var b: nTime = -4       # works
##     var c = to_nTime(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "Time" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nTime      # works
##     var b: nTime = null     # works
##     var c = to_nTime(null)  # works
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
##     var a: nTime = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: Time, y: Time)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nTime.-(a: nTime,
##     b: nTime)[declared in src/nullable/nTime.nim(161, 5)] match for: (nTime, Time literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an Time, add the numbers, and then convert the answer back to an ``nTime``, or
##
## b. convert ``2`` to a ``nTime``, and then add the numbers as ``nTime``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nTime``. Such as:
## 
## .. code:: nim
##
##     var a: nTime = 3
##     a = a + 2.nTime
##


{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nTime, Time)

converter to_nTime*(n: Time): nTime = 
  result = nTime(kind: nlkValue)
  result.stored_value = n

# You cannot convert a string to a nTime
# converter to_nTime*(n: char): nTime = 

# You cannot convert a float to a nTime
# converter to_nTime*(n: char): nTime = 

# You cannot convert a int to a nTime
# converter to_nTime*(n: char): nTime = 

converter from_nTime_to_Time*(n: nTime): Time = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nTime: Cannot convert nothing to an Time.")
  of nlkNull:
    raise newException(ValueError, "nTime: Cannot convert null to an Time.")
  of nlkError:
    raise newException(ValueError, "nTime: Cannot convert an error to an Time.")

proc make_nothing(n: var nTime) =
  ## Force the nTime into a null state
  n = nTime(kind: nlkNull, hints: n.hints)

proc make_null(n: var nTime) =
  ## Force the nTime into a null state
  n = nTime(kind: nlkNull, hints: n.hints)


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

# The '+' operator has no meaning to nTime

# The '-' operator has no meaning to nTime

# The '*' operator has no meaning to nTime

# The '/' operator has no meaning to nTime

# The '<' operator has no meaning to nTime

# The '>' operator has no meaning to nTime

proc `==`*(a: nTime, b: nTime): bool =
  ## Operator: EQUAL-TO (nTime vs nTime)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nTime`` values.
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

proc `==`*(a: nTime, b: Time): bool =
  ## Operator: EQUAL-TO (nTime vs Time)
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

proc `==`*(a: Time, b: nTime): bool =
  ## Operator: EQUAL-TO (Time vs nTime)
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

# The '@' operator has no meaning to nTime

# The '~' operator has no meaning to nTime

# The '&' operator has no meaning to nTime

# The 'div' operator has no meaning to nTime

# The '%' operator has no meaning to nTime

# The '!' operator has no meaning to nTime

# The '?' operator has no meaning to nTime

# The '^' operator has no meaning to nTime

# The '.' operator has no meaning to nTime

# The '|' operator has no meaning to nTime

# The 'and' operator has no meaning to nTime

# The 'not' operator has no meaning to nTime
