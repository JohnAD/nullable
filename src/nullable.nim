## NULLABLE
##
## Creates basic nim "types" that can, in addition to their normal values,
## take on the values of Null or Error.
##
## EXAMPLE FOR INTEGERS
##
## Nim has a integer type integrated into the language called "int". It is
## normally used like:
## 
## .. code:: nim
##
##     var x: int = 5
##
## This library introduces another "int" named "Nint". It can be used in a
## much more flexible manner because it can also be set to ``null`` or
## ``error``.
##
## .. code:: nim
##
##     import nullable
##
##     var y: Nint = null                  # storing "nothing"
##     y = Error("something went wrong")   # storing an error instead
##     y = 5                               # store an actual integer
##
##     # you can still do standard stuff:
##
##     var z = y       # z is now a Nint valued at 5
##     z = y * 2       # z is now a Nint valued at 10
##     echo "z = ", z  # the message 'z = 10' displays on the screen
##

# proof-of-concept


type
  NullClass = object
    exists: bool
  Nint = object
    value: int       # defaults to 0
    null: bool       # defaults to false (not null)
    error: string    # defaults to ""
  Nstring = object
    value: string    # defaults to ""
    null: bool       # defaults to false (not null)
    error: string    # defaults to ""

const
  null = NullClass(exists: true)


# "error" overrides "null" overrides "real value"
proc `$`(n: Nint): string =
  result = "unknown"
  if n.error != "":
    result = "error(" & n.error & ")"
  elif n.null:
    result = "null"
  else:
    result = $n.value

proc `=`(n: var Nint, src: Nint) =
  n.value = src.value
  n.null = src.null
  n.error = src.error

converter toNint(n: int): Nint = 
  result.value = n
  result.null = false
  result.error = ""

converter toNint(n: NullClass): Nint =
  result.value = 0
  result.null = n.exists
  result.error = ""

proc error(n: var Nint, msg: string) =
  n.error = msg

proc has_error(n: Nint): bool =
  result = n.error != ""

proc is_null(n: Nint): bool =
  result = n.null
  if n.has_error():
    result = false

proc is_good(n: Nint): bool =
  result = true
  if n.has_error():
    result = false
  if n.is_null():
    result = false

proc `+`(a: Nint, b: Nint): Nint =
  if a.has_error():
    error(result, a.error)
  elif b.has_error():
    error(result, b.error)
  elif a.is_null():
    error(result, "Cannot add a real number with null")
  elif b.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.value = a.value + b.value

proc `+`(a: Nint, b: int): Nint =
  if a.has_error():
    error(result, a.error)
  elif a.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.value = a.value + b

proc `+`(a: int, b: Nint): Nint =
  if b.has_error():
    error(result, b.error)
  elif b.is_null():
    error(result, "Cannot add a real number with null")
  else:
    result.value = a + b.value


# test assignment

var a: Nint = 3
echo "3 = ", a
a = null
var c = a
echo "null = ", a
error(a, "something_wrong") # we can be fancy and pass real exceptions later
echo "err = ", a

# test math

var b: Nint = 4
echo "4 = ", b
b = b + 10
echo "14 = ", b
b = b + 2
echo "16 = ", b
b = 5 + b
echo "21 = ", b
a = a + 10 # should still be an error becase 'a' started as an error
echo "err = ", a

# checks

if a.has_error():
  echo "a has an error"
if b.is_good():
  echo "b has a value"
if c.is_null():
  echo "c is null"
# 