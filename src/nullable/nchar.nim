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

## The ``nchar`` object type represents a "nullable" char.
##
## It should behave just like the native 'char' type in most instances; except
## where the possible ``null`` or Error states are involved.
##
## Further details are in the "nchar Reference" page linked at the bottom.
##
## Handling Declaration and Assignment
## -----------------------------------
## You will need need to explicity assign the variable to be of type ``nchar``
## if using a literal number. That is because literal chars default to
## the built in data type of ``char``.
## 
## .. code:: nim
##
##     import nullable
##
##     var a = 3.nchar         # works
##     var b: nchar = -4       # works
##     var c = to_nchar(78)    # works
##     var d = c              # also works
##     a = -99                # still works
##
##     var e = 23             # does not work; "e" will be an "char" instead
##
## and, of course, you can assign the value to ``null``, but again, you must
## be explicit when declaring the variable.
##
## .. code:: nim
##
##     import nullable
##
##     var a = null.nchar      # works
##     var b: nchar = null     # works
##     var c = to_nchar(null)  # works
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
##     var a: nchar = 3
##     a = a + 2         # compiler error here!
##
## You will get a compiler message similar to:
##
## .. code:: text
##
##     example.nim(3, 7) Error: ambiguous call; both system.-(x: char, y: char)[declared in 
##     ../../.choosenim/toolchains/nim-0.19.4/lib/system.nim(942, 5)] and nchar.-(a: nchar,
##     b: nchar)[declared in src/nullable/nchar.nim(161, 5)] match for: (nchar, char literal(2))
##
## Essentially, the nim compiler doesn't know whether to:
##
## a. convert ``a`` to an char, add the numbers, and then convert the answer back to an ``nchar``, or
##
## b. convert ``2`` to a ``nchar``, and then add the numbers as ``nchar``s
##
## Hopefully, one day, the compiler will consider the assignment operation type
## as higher priority and choose (b) when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value(s) to a ``nchar``. Such as:
## 
## .. code:: nim
##
##     var a: nchar = 3
##     a = a + 2.nchar
##


{.hint[XDeclaredButNotUsed]:off.}

generate_generic_handling(nchar, char)

converter to_nchar*(ch: char): nchar = 
  result = nchar(kind: nlkValue)
  result.stored_value = ch

converter to_nchar*(s: string): nchar = 
  if s.len > 0:
    result = nchar(kind: nlkValue)
    result.stored_value = s[0]
  else:
    result = nchar(kind: nlkNothing)

# You cannot convert a float to a nchar
# converter to_nchar*(n: char): nchar = 

# You cannot convert a int to a nchar
# converter to_nchar*(n: char): nchar = 

converter from_nchar_to_char*(n: nchar): char = 
  case n.kind:
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "nchar: Cannot convert nothing to an char.")
  of nlkNull:
    raise newException(ValueError, "nchar: Cannot convert null to an char.")
  of nlkError:
    raise newException(ValueError, "nchar: Cannot convert an error to an char.")


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

# The '+' operator has no meaning to nchar

# The '-' operator has no meaning to nchar

# The '*' operator has no meaning to nchar

# The '/' operator has no meaning to nchar

# The '<' operator has no meaning to nchar

# The '>' operator has no meaning to nchar

proc `==`*(a: nchar, b: nchar): bool =
  ## Operator: EQUAL-TO (nchar vs nchar)
  ##
  ## Represented by two equal symbols "==" symbol, this operation compares two
  ## ``nchar`` values.
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

proc `==`*(a: nchar, b: char): bool =
  ## Operator: EQUAL-TO (nchar vs char)
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

proc `==`*(a: char, b: nchar): bool =
  ## Operator: EQUAL-TO (char vs nchar)
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

# The '@' operator has no meaning to nchar

# The '~' operator has no meaning to nchar

# The '&' operator has no meaning to nchar

# The 'div' operator has no meaning to nchar

# The '%' operator has no meaning to nchar

# The '!' operator has no meaning to nchar

# The '?' operator has no meaning to nchar

# The '^' operator has no meaning to nchar

# The '.' operator has no meaning to nchar

# The '|' operator has no meaning to nchar

# The 'and' operator has no meaning to nchar

# The 'not' operator has no meaning to nchar
