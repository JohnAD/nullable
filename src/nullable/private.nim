#
# Private routines for use by the library
#

#
# Nothing here is seen by the documentation engine or external users
#

type
  ValidErrors* = ValueError | ArithmeticError | ResourceExhaustedError | OSError | IOError

template generate_generic_handling*(target, typ: untyped): untyped =

  type
    target* = object
      case kind: NullableKind
      of nlkValue:
        stored_value: typ
      of nlkNothing:
        discard
      of nlkNull:
        discard
      of nlkError:
        errors*: seq[ExceptionClass]
      hints: seq[Hint]

  proc `$`*(n: target): string = 
    case n.kind:
    of nlkValue:
      result = $n.stored_value
    of nlkNothing:
      result = "nothing"
    of nlkNull:
      result = "null"
    of nlkError:
      result = $n.errors

  proc repr*(n: target): string = 
    result = name(target) & "("
    case n.kind:
    of nlkValue:
      result &= "value:" & $n.stored_value
    of nlkNothing:
      result &= "nothing"
    of nlkNull:
      result &= "null"
    of nlkError:
      result &= error_repr(n.errors)
    result &= ")"

  proc `=`*(n: var target, src: target) = 
    case src.kind:
    of nlkValue:
      n = target(kind: nlkValue, stored_value: src.stored_value)
    of nlkNothing:
      n = target(kind: nlkNothing)
    of nlkNull:
      n = target(kind: nlkNull)
    of nlkError:
      n = target(kind: nlkError, errors: src.errors)
    n.hints = src.hints

  proc get_value*(n: target): typ =
    case n.kind:
    of nlkValue:
      result = n.stored_value
    else:
      raise newException(ValueError, "current state of variable does not have a value to get")

  proc make_nothing(n: var target) =
    n = target(kind: nlkNothing, hints: n.hints)

  proc make_null(n: var target) =
    n = target(kind: nlkNull, hints: n.hints)

  # converter to_target*(n: N[typ]): target =
  #   if n.is_null:
  #     result = target(kind: nlkNull)
  #   if n.is_nothing:
  #     result = target(kind: nlkNothing)
  #   if n.has_value:
  #     result = target(kind: nlkValue)
  #     result.stored_value = n.get()
  #   if n.has_error:
  #     result = target(kind: nlkError)
  #     result.errors = n.errors

  proc actualSetError*(n: var target, e: ValidErrors, loc: string) =
    if n.kind != nlkError:
      n = target(kind: nlkError)
    var newErr = ExceptionClass()
    newErr.msg = e.msg
    newErr.exception_type = name(type(e))
    newErr.trace = loc
    n.errors.add newErr

  proc actualSetError*(n: var target, e: target, loc: string) =
    if n.kind != nlkError:
      n = target(kind: nlkError)
    n.errors &= e.errors


  proc has_error*(n: target): bool =
    ## Check to see if n has an error associated with it.
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = ValueError("Too small.")
    ##     if a.has_error:
    ##       echo "Error found: " & $a
    ##
    case n.kind:
    of nlkError:
      return true
    else:
      return false

  proc is_nothing*(n: target): bool =
    ## Check to see if n is unknown (a null).
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = null
    ##     if a.is_null:
    ##       echo "It is null."
    ##
    case n.kind:
    of nlkNothing:
      return true
    else:
      return false

  proc is_null*(n: target): bool =
    ## Check to see if n is unknown (a null).
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = null
    ##     if a.is_null:
    ##       echo "It is null."
    ##
    case n.kind:
    of nlkNull:
      return true
    else:
      return false

  proc has_value*(n: target): bool =
    ## Check to see if n has a legitimate number. In other words, it verifies that it is not 'null' and it does not
    ## have an error. A newly declared ``nint`` defaults to 0 (zero) and is good.
    ##
    ## .. code:: nim
    ##
    ##     var a: nint = 5
    ##     if a.is_good:
    ##       echo "a = " & $a
    ##
    case n.kind:
    of nlkValue:
      return true
    else:
      return false
