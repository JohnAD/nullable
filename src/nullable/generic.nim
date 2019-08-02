import
  strutils,
  typetraits

import
  core,
  private


type
  N*[T] = object
    ## A type that wraps T with extra functions that allow it have a state of
    ## nothing, null, error, or T.
    ##
    ## Accessing or using ``kind``, ``stored_value``, or ``hints`` outside the
    ## library is generally a bad idea.
    case kind*: NullableKind
    of nlkValue:
      stored_value: T
    of nlkNothing:
      discard
    of nlkNull:
      discard
    of nlkError:
      errors*: seq[ExceptionClass]
    hints: seq[Hint]


proc `$`*[T](n: N[T]): string = 
  case n.kind:
  of nlkValue:
    result = $n.stored_value
  of nlkNothing:
    result = "nothing"
  of nlkNull:
    result = "null"
  of nlkError:
    result = $n.errors

proc get*[T](n: N[T]): T =
  if n.kind == nlkValue: 
    result = n.stored_value
  else:
    # TODO: Improve error message
    raise newException(KeyError, "N[T] does not have a value, get not permitted.")

proc getValue*[T](n: N[T]): T =
  if n.kind == nlkValue: 
    result = n.stored_value
  else:
    # TODO: Improve error message
    raise newException(KeyError, "N[T] does not have a value, get not permitted.")


proc set*[T](n: var N[T], newValue: T) =
  if n.kind != nlkValue: 
    n = N[T](kind: nlkValue)
  n.stored_value = newValue

proc repr*[T](n: N[T]): string = 
  result = "N[" & name(T) & "]"
  case n.kind:
  of nlkValue:
    let inside = $n.stored_value
    if inside.startsWith("("):
      result &= inside
    else:
      result &= "($1)".format(inside)
  of nlkNothing:
    result &= "(nothing)"
  of nlkNull:
    result &= "(null)"
  of nlkError:
    result &= error_repr(n.errors)


template nothing*(T: untyped): untyped =
  N[T](kind: nlkNothing)

template null*(T: untyped): untyped =
  N[T](kind: nlkNull)


proc actualSetError*[T](n: var N[T], e: ValidErrors, loc: string) =
  if n.kind != nlkError:
    n = N[T](kind: nlkError)
  var newErr = ExceptionClass()
  newErr.msg = e.msg
  newErr.exception_type = name(type(e))
  newErr.trace = loc
  n.errors.add newErr

proc actualSetError*[T](n: var N[T], e: N[T], loc: string) =
  if n.kind != nlkError:
    n = N[T](kind: nlkError)
  n.errors &= e.errors


converter to_nullable_type*[T](n: T): N[T] = 
  result = N[T](kind: nlkValue)
  result.stored_value = n

converter from_nullable_type*[T](n: N[T]): T = 
  case n.kind
  of nlkValue:
    result = n.stored_value
  of nlkNothing:
    raise newException(ValueError, "$1: Cannot convert nothing to $2.".format(name(N[T]), name(T)))
  of nlkNull:
    raise newException(ValueError, "$1: Cannot convert null to $2.".format(name(N[T]), name(T)))
  of nlkError:
    raise newException(ValueError, "$1: Cannot convert an error to $2.".format(name(N[T]), name(T)))

proc hasError*[T](n: N[T]): bool =
  ## Check to see if n has an error associated with it.
  ##
  ## .. code:: nim
  ##
  ##     var a: N[T] = ValueError("Too small.")
  ##     if a.has_error:
  ##       echo "Error found: " & $a
  ##
  case n.kind:
  of nlkError:
    return true
  else:
    return false

proc isNothing*[T](n: N[T]): bool =
  ## Check to see if n is unknown (a null).
  ##
  ## .. code:: nim
  ##
  ##     var a: N[T] = null
  ##     if a.is_null:
  ##       echo "It is null."
  ##
  case n.kind:
  of nlkNothing:
    return true
  else:
    return false

proc isNull*[T](n: N[T]): bool =
  ## Check to see if n is unknown (a null).
  ##
  ## .. code:: nim
  ##
  ##     var a: N[T] = null
  ##     if a.is_null:
  ##       echo "It is null."
  ##
  case n.kind:
  of nlkNull:
    return true
  else:
    return false

proc hasValue*[T](n: N[T]): bool =
  ## Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
  ## have an error. A newly declared ``N[T]`` defaults to 0 (zero) and is good.
  ##
  ## .. code:: nim
  ##
  ##     var a: N[T] = 5
  ##     if a.is_good:
  ##       echo "a = " & $a
  ##
  case n.kind:
  of nlkValue:
    return true
  else:
    return false
