import
  strutils,
  typetraits

import
  core,
  private,
  generic

## TODO
##

{.hint[XDeclaredButNotUsed]:off.}

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

# The '+' operator has no meaning to N[bool]

# The '-' operator has no meaning to N[bool]

# The '*' operator has no meaning to N[bool]

# The '/' operator has no meaning to N[bool]

# The '<' operator has no meaning to N[bool]

# The '>' operator has no meaning to N[bool]

proc `==`*(a: N[bool], b: N[bool]): bool =
  ## Operator: EQUAL-TO (N[bool] vs N[bool])
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``N[bool]`` values.
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

proc `==`*(a: N[bool], b: bool): bool =
  ## Operator: EQUAL-TO (N[bool] vs bool)
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
  of nlkValue:
    return a.get() == b

proc `==`*(a: bool, b: N[bool]): bool =
  ## Operator: EQUAL-TO (bool vs N[bool])
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
    return a == b.get()

# The '@' operator has no meaning to N[bool]

# The '~' operator has no meaning to N[bool]

# The '&' operator has no meaning to N[bool]

# The 'div' operator has no meaning to N[bool]

# The '%' operator has no meaning to N[bool]

# The '!' operator has no meaning to N[bool]

proc `!`*(a: N[bool]): bool =
  ## Operator: NOT (bool)
  ##
  case a.kind:
  of nlkError:
    raise newException(ValueError, "N[bool]: Cannot convert error to a bool.")
  of nlkNull:
    raise newException(ValueError, "N[bool]: Cannot convert null to a bool.")
  of nlkNothing:
    raise newException(ValueError, "N[bool]: Cannot convert nothing to a bool.")
  of nlkValue:
    return !a.get()

# The '?' operator has no meaning to N[bool]

# The '^' operator has no meaning to N[bool]

# The '.' operator has no meaning to N[bool]

# The '|' operator has no meaning to N[bool]

# The 'and' operator has no meaning to N[bool]

# The 'not' operator has no meaning to N[bool]
