import
  logging,
  strutils

export
  Level

type
  NullableKind* = enum
    nlkValue,
    nlkNothing,
    nlkNull,
    nlkError

type
  ValidErrors* = ValueError | ArithmeticError | ResourceExhaustedError | OSError | IOError | FieldError

type
  Judgement* = enum
    ## Category of judgement for a hint.
    ## 
    ## info
    ##     neutral (but ok if forced to judge)
    ## 
    ## success
    ##     ok
    ## 
    ## warning
    ##     ok; but with reservations
    ## 
    ## danger
    ##     not ok
    ##
    ## These categories are inspired by the Bootstrap framework
    ## (https://getbootstrap.com/).
    jdgInfo,
    jdgSuccess,
    jdgWarning,
    jdgDanger
  Audience* = enum
    ## Distribution limits for news of a hint.
    ## 
    ## ops
    ##   only seen by those with server/system maintainer clearance
    ## 
    ## admin
    ##   only seen by end-users with admin clearance (and ops)
    ## 
    ## user
    ##   only seen by regular users (and admin and ops)
    ## 
    ## public
    ##   the whole world (no restrictions)
    audOps,
    audAdmin,
    audUser,
    audPublic

type
  ExceptionClass* = object
    msg*: string
    exception_type*: string
    level*: Level            # defaults to 'lvlAll'
    audience*: Audience      # defaults to 'ops'
    trace*: string           # where in source code was error generated?

type
  Hint* = object
    msg*: string           # defaults to ""
    level*: Level          # defaults to 'lvlAll'
    judgement*: Judgement  # defaults to 'detail'
    audience*: Audience    # defaults to 'ops'

type
  N*[T] = object
    ## A type that wraps T with extra functions that allow it have a state of
    ## nothing, null, error, or T.
    ##
    ## Accessing or using ``kind``, ``stored_value``, or ``hints`` outside the
    ## library is generally a bad idea.
    case kind*: NullableKind
    of nlkValue:
      stored_value*: T
    of nlkNothing:
      discard
    of nlkNull:
      discard
    of nlkError:
      errors*: seq[ExceptionClass]
    hints*: seq[Hint]

template setError*(n: untyped, e: untyped, level: untyped, audience: untyped): untyped =
  let pos = instantiationInfo()
  actualSetError(n, e, $pos, level=level, audience=audience)

template setError*(n: untyped, e: untyped): untyped =
  let pos = instantiationInfo()
  actualSetError(n, e, $pos, level=lvlDebug, audience=audAdmin)

proc `$`*(e: ExceptionClass): string = 
  result = "$1($2)".format(e.exception_type, e.msg)

proc error_repr*(err_list: seq[ExceptionClass]): string =
  result &= "@[\n"
  for err in err_list:
      result &= "  $1($2) at $3\n".format(err.exception_type, err.msg, err.trace)
  result &= "]"
