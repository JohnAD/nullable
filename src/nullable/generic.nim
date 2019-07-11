import
  strutils,
  typetraits

import
  core,
  private


type
  Nullable*[T] = object
    ## A type that wraps T with extra functions that allow it have a state of
    ## nothing, null, error, or T.
    ##
    ## Accessing or using ``kind``, ``stored_value``, or ``hints`` outside the
    ## library is generally a bad idea.
    case kind: NullableKind
    of nlkValue:
      stored_value: T
    of nlkNothing:
      discard
    of nlkNull:
      discard
    of nlkError:
      errors*: seq[ExceptionClass]
    hints: seq[Hint]


proc `$`*[T](n: Nullable[T]): string = 
  case n.kind:
  of nlkValue:
    result = $n.stored_value
  of nlkNothing:
    result = "nothing"
  of nlkNull:
    result = "null"
  of nlkError:
    result = $n.errors

proc get*[T](n: Nullable[T]): T =
  if n.kind == nlkValue: 
    result = n.stored_value
  else:
    # TODO: Improve error message
    raise newException(KeyError, "Nullable[T] does not have a value, get not permitted.")

proc repr*[T](n: Nullable[T]): string = 
  result = "Nullable[" & name(T) & "]"
  case n.kind:
  of nlkValue:
    result &= $n.stored_value
  of nlkNothing:
    result &= "(nothing)"
  of nlkNull:
    result &= "(null)"
  of nlkError:
    result &= error_repr(n.errors)


template nothing*(T: untyped): untyped =
  Nullable[T](kind: nlkNothing)

template null*(T: untyped): untyped =
  Nullable[T](kind: nlkNull)


proc actualSetError*[T](n: var Nullable[T], e: ValidErrors, loc: string) =
  if n.kind != nlkError:
    n = Nullable[T](kind: nlkError)
  var newErr = ExceptionClass()
  newErr.msg = e.msg
  newErr.exception_type = name(type(e))
  newErr.trace = loc
  n.errors.add newErr

proc actualSetError*[T](n: var Nullable[T], e: Nullable[T], loc: string) =
  if n.kind != nlkError:
    n = Nullable[T](kind: nlkError)
  n.errors &= e.errors


converter to_nullable_type*[T](n: T): Nullable[T] = 
  result = Nullable[T](kind: nlkValue)
  result.stored_value = n

proc has_error*[T](n: Nullable[T]): bool =
  ## Check to see if n has an error associated with it.
  ##
  ## .. code:: nim
  ##
  ##     var a: Nullable[T] = ValueError("Too small.")
  ##     if a.has_error:
  ##       echo "Error found: " & $a
  ##
  case n.kind:
  of nlkError:
    return true
  else:
    return false

proc is_nothing*[T](n: Nullable[T]): bool =
  ## Check to see if n is unknown (a null).
  ##
  ## .. code:: nim
  ##
  ##     var a: Nullable[T] = null
  ##     if a.is_null:
  ##       echo "It is null."
  ##
  case n.kind:
  of nlkNothing:
    return true
  else:
    return false

proc is_null*[T](n: Nullable[T]): bool =
  ## Check to see if n is unknown (a null).
  ##
  ## .. code:: nim
  ##
  ##     var a: Nullable[T] = null
  ##     if a.is_null:
  ##       echo "It is null."
  ##
  case n.kind:
  of nlkNull:
    return true
  else:
    return false

proc has_value*[T](n: Nullable[T]): bool =
  ## Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
  ## have an error. A newly declared ``Nullable[T]`` defaults to 0 (zero) and is good.
  ##
  ## .. code:: nim
  ##
  ##     var a: Nullable[T] = 5
  ##     if a.is_good:
  ##       echo "a = " & $a
  ##
  case n.kind:
  of nlkValue:
    return true
  else:
    return false
