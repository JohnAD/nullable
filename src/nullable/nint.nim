import
  strutils

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
## Sadly, nim does not yet object types in a full-parity manner yet, so you
## will *sometimes* encounter an "ambiguous call" error. For example:
##
## .. code:: nim
##
##     import nullable
##     var a: nint = 3
##     a = a + 2
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
## - convert ``a`` to an int, add the numbers, and then convert the plus operation back to an ``nint``, or
##
## - convert ``2`` to a ``nint``, and then add the numbers
##
## Hopefully, one day, the compiler will consider the assignment operation type as higher priority when handling such conflict.
##
## In the mean time, if you get such an error, explicity convert the value to a ``nint`` with ``to_nint``. Such as:
## 
## .. code:: nim
##
##     var a: nint = 3
##     a = a + to_nint(2)
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
    stored_value: int       # defaults to 0
    null: bool              # defaults to false (not null)
    error: string           # defaults to ""
    hints: seq[Hint]        # defaults to empty

# "error" overrides "null" which overrides "real value"
proc deduce(n: nint): NState =
  if n.error != "":
    return state_errored
  elif n.null == true:
    return state_nulled
  return state_valued


{.hint[XDeclaredButNotUsed]:off.}

proc `$`*(n: nint): string = 
  result = "unknown"
  var s = deduce(n)
  if s==state_errored:
    result = "error(" & n.error & ")"
  elif s==state_nulled:
    result = "null"
  else:
    result = $n.stored_value

proc `=`*(n: var nint, src: nint) = 
  n.stored_value = src.stored_value
  n.null = src.null
  n.error = src.error
  n.hints = src.hints

# You cannot convert a bool to a nint
# converter to_nint*(n: bool): nint = 

# You cannot convert a char to a nint
# converter to_nint*(n: char): nint = 

converter to_nint*(n: string): nint = 
  try:
    result.stored_value = parseInt(n)
    result.null = false
    result.error = ""
    result.hints = @[]
  except ValueError:
    result.stored_value = 0
    result.null = false
    result.error = "Could not convert string to nint."
    result.hints = @[]

converter to_nint*(n: int): nint = 
  result.stored_value = n
  result.null = false
  result.error = ""
  result.hints = @[]

converter to_nint*(n: float): nint = 
  result.stored_value = int(n)
  result.null = false
  result.error = ""
  result.hints = @[]

converter to_nint*(n: NullClass): nint =
  result.stored_value = 0
  result.null = true
  result.error = ""
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

proc error*(n: var nint, msg: string) =
  n.error = msg

proc has_error*(n: nint): bool =
  result = n.error != ""

proc is_null*(n: nint): bool =
  var s = deduce(n)
  if s==state_nulled:
    result = true
  else:
    result = false

proc is_good*(n: nint): bool =
  var s = deduce(n)
  if s==state_valued:
    result = true
  else:
    result = false

proc `+`*(a: nint, b: nint): nint =
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    error(result, a.error)
  elif sb==state_errored:
    error(result, b.error)
  elif sa==state_nulled:
    error(result, "Cannot add a real number with null")
  elif sb==state_nulled:
    error(result, "Cannot add a real number with null")
  else:
    result.stored_value = a.stored_value + b.stored_value
  # TODO: handle hints

proc `-`*(a: nint, b: nint): nint =
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    error(result, a.error)
  elif sb==state_errored:
    error(result, b.error)
  elif sa==state_nulled:
    error(result, "Cannot subtract a real number with null")
  elif sb==state_nulled:
    error(result, "Cannot subtract a real number with null")
  else:
    result.stored_value = a.stored_value - b.stored_value
  # TODO: handle hints

proc `*`*(a: nint, b: nint): nint =
  var sa = deduce(a)
  var sb = deduce(b)
  if sa==state_errored:
    error(result, a.error)
  elif sb==state_errored:
    error(result, b.error)
  elif sa==state_nulled:
    error(result, "Cannot multiply a real number with null")
  elif sb==state_nulled:
    error(result, "Cannot multiply a real number with null")
  else:
    result.stored_value = a.stored_value * b.stored_value
  # TODO: handle hints

# TODO: handle this when nfloat is working? Or will nfloat convert automatically?
# proc `/`*(a: nint, b: nint): nfloat =
#   var sa = deduce(a)
#   var sb = deduce(b)
#   if sa==state_errored:
#     error(result, a.error)
#   elif sb==state_errored:
#     error(result, b.error)
#   elif sa==state_nulled:
#     error(result, "Cannot divide a real number with null")
#   elif sb==state_nulled:
#     error(result, "Cannot divide a real number with null")
#   else:
#     result.stored_value = a.stored_value / b.stored_value
#   # TODO: handle hints

