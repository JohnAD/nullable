import
  strutils,
  typetraits

import
  core,
  hint,
  private



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
  ## makes 'n' to have the 'newValue'.
  ##
  ## the difference between:
  ##
  ##    var abc: N[int]
  ##    abc.set(3)
  ##
  ## and
  ##
  ##    var abc: N[int]
  ##    abc = 3
  ##
  ## is that set will preserve any hints that have been given to the 
  ## variable. But, assigning the variable directly will wipe out any
  ## history.
  if n.kind != nlkValue: 
    n = N[T](kind: nlkValue, hints: n.hints)
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

proc makeNothing*[T](n: var N[T]) =
  ## makes the parameter 'n' to be 'nothing'.
  ##
  ## the difference between:
  ##
  ##    var abc: N[int] = 4
  ##    abc.makeNothing()
  ##
  ## and
  ##
  ##    var abc: N[int] = 4
  ##    abc = nothing(int)
  ##
  ## is that makeNothing will preserve any hints that have been given to the 
  ## variable. But, assigning a variable to ``nothing(T)`` will wipe out any
  ## history.
  if n.kind != nlkNothing:
    n = N[T](kind: nlkNothing, hints: n.hints)

proc makeNull*[T](n: var N[T]) =
  ## makes the parameter 'n' to be 'null'.
  ##
  ## the difference between:
  ##
  ##    var abc: N[int] = 4
  ##    abc.makeNull()
  ##
  ## and
  ##
  ##    var abc: N[int] = 4
  ##    abc = null(int)
  ##
  ## is that makeNull will preserve any hints that have been given to the 
  ## variable. But, assigning a variable to ``null(T)`` will wipe out any
  ## history.
  if n.kind != nlkNothing:
    n = N[T](kind: nlkNothing, hints: n.hints)

proc actualSetError*[T](n: var N[T], e: ValidErrors, loc: string, level: Level, audience: Audience) =
  if n.kind != nlkError:
    n = N[T](kind: nlkError, hints: n.hints)
  var newErr = ExceptionClass()
  newErr.msg = e.msg
  newErr.exception_type = name(type(e))
  newErr.trace = loc
  newErr.level = level
  newErr.audience = audience
  n.errors.add newErr

proc actualSetError*[T](n: var N[T], e: ref Exception, loc: string, level: Level, audience: Audience) =
  if n.kind != nlkError:
    n = N[T](kind: nlkError, hints: n.hints)
  var newErr = ExceptionClass()
  newErr.msg = e.msg
  newErr.exception_type = name(type(e))
  newErr.trace = loc
  newErr.level = level
  newErr.audience = audience
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
