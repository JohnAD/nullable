import
  strutils,
  typetraits,
  oids

import
  core,
  private,
  generic

export
  oids

## The ``nOid`` object type represents a "nullable" Oid.
##
## It should behave just like the native 'Oid' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nOid Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nOid``
## if using a literal number. That is because literal Oids default to
## the built in data type of ``Oid``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nOid         # works
##     var b: nOid = -4       # works
##     var c = to_nOid(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "Oid" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nOid      # works
##     var b: nOid = null     # works
##     var c = to_nOid(null)  # works
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
##     var a: nOid = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: Oid, y: Oid)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nOid.-(a: nOid,
##     b: nOid)[declared in src/nullable/nOid.nim(161, 5)] match for: (nOid, Oid literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an Oid, add the numbers, and then convert the answer back to an ``nOid``, or
##
## b. convert ``2`` to a ``nOid``, and then add the numbers as ``nOid``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nOid``. Such as:
## 
## .. code:: nim
##
##     var a: nOid = 3
##     a = a + 2.nOid
##


{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nOid, Oid)

converter to_nOid*(n: Oid): nOid = 
  result = nOid(kind: nlkValue)
  result.stored_value = n

converter to_nOid*(n: string): nOid = 
  result = nOid(kind: nlkValue)
  result.stored_value = parseOid(n)

# You cannot convert a float to a nOid
# converter to_nOid*(n: char): nOid = 

# You cannot convert a int to a nOid
# converter to_nOid*(n: char): nOid = 

converter from_nOid_to_Oid*(n: nOid): Oid = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nOid: Cannot convert nothing to an Oid.")
  of nlkNull:
    raise newException(ValueError, "nOid: Cannot convert null to an Oid.")
  of nlkError:
    raise newException(ValueError, "nOid: Cannot convert an error to an Oid.")

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

# The '+' operator has no meaning to nOid

# The '-' operator has no meaning to nOid

# The '*' operator has no meaning to nOid

# The '/' operator has no meaning to nOid

# The '<' operator has no meaning to nOid

# The '>' operator has no meaning to nOid

proc `==`*(a: nOid, b: nOid): bool =
  ## Operator: EQUAL-TO (nOid vs nOid)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nOid`` values.
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

proc `==`*(a: nOid, b: Oid): bool =
  ## Operator: EQUAL-TO (nOid vs Oid)
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

proc `==`*(a: Oid, b: nOid): bool =
  ## Operator: EQUAL-TO (Oid vs nOid)
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

# The '@' operator has no meaning to nOid

# The '~' operator has no meaning to nOid

# The '&' operator has no meaning to nOid

# The 'div' operator has no meaning to nOid

# The '%' operator has no meaning to nOid

# The '!' operator has no meaning to nOid

# The '?' operator has no meaning to nOid

# The '^' operator has no meaning to nOid

# The '.' operator has no meaning to nOid

# The '|' operator has no meaning to nOid

# The 'and' operator has no meaning to nOid

# The 'not' operator has no meaning to nOid
