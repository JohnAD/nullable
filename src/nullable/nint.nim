## module for ``nint``
##

import core

type
  nint* = object
    stored_value: int       # defaults to 0
    null: bool              # defaults to false (not null)
    error: string           # defaults to ""

{.hint[XDeclaredButNotUsed]:off.}

# "error" overrides "null" overrides "real value"
proc `$`*(n: nint): string = 
  result = "unknown"
  if n.error != "":
    result = "error(" & n.error & ")"
  elif n.null:
    result = "null"
  else:
    result = $n.stored_value

proc `=`*(n: var nint, src: nint) = 
  n.stored_value = src.stored_value
  n.null = src.null
  n.error = src.error

converter to_nint*(n: int): nint = 
  result.stored_value = n
  result.null = false
  result.error = ""

converter to_nint*(n: NullClass): nint =
  result.stored_value = 0
  result.null = true
  result.error = ""

proc error*(n: var nint, msg: string) =
  n.error = msg

proc has_error*(n: nint): bool =
  result = n.error != ""

proc is_null*(n: nint): bool =
  result = n.null
  if n.has_error():
    result = false

proc is_good*(n: nint): bool =
  result = true
  if n.has_error():
    result = false
  if n.is_null():
    result = false

proc `+`*(a: nint, b: nint): nint =
  if a.has_error():
    error(result, a.error)
  elif b.has_error():
    error(result, b.error)
  elif a.is_null():
    error(result, "Cannot add a real number with null")
  elif b.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.stored_value = a.stored_value + b.stored_value

proc `+`*(a: nint, b: int): nint =
  if a.has_error():
    error(result, a.error)
  elif a.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.stored_value = a.stored_value + b

proc `+`*(a: int, b: nint): nint =
  if b.has_error():
    error(result, b.error)
  elif b.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.stored_value = a + b.stored_value
