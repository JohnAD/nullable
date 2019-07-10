import
  logging,
  strutils

export Level

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
    ## (https://getbootstrap.com/)
    info,
    success,
    warning,
    danger
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
    ops,
    admin,
    user,
    public

type
  NullableKind* = enum
    nlkValue,
    nlkNothing,
    nlkNull,
    nlkError
    # state_valued,
    # state_nothing,
    # state_nulled,
    # state_errored

type
  NullClass* = object
    exists: bool          # note: this field is not actually used.
  NothingClass* = object
    exists: bool
  Hint* = object
    msg*: string           # defaults to ""
    level*: Level          # defaults to 'lvlAll'
    judgement*: Judgement  # defaults to 'info'
    audience*: Audience    # defaults to 'ops'
  ExceptionClass* = object
    flag*: bool
    msg*: string
    exception_type*: string

proc `$`*(e: ExceptionClass): string = 
  if e.flag:
    result = "error($1, $2)".format(e.exception_type, e.msg)
  else:
    result = "error(none)"

  # nbool* = object
  #   stored_value: bool      # defaults to false
  #   null: bool              # defaults to false (not null)
  #   error: string           # defaults to ""
  # nchar* = object
  #   stored_value: char      # defaults to ??
  #   null: bool              # defaults to false (not null)
  #   error: string           # defaults to ""
  # nstring* = object
  #   stored_value: string    # defaults to ""
  #   null: bool              # defaults to false (not null)
  #   error: string           # defaults to ""
  # nfloat* = object
  #   stored_value: float     # defaults to 0.0
  #   null: bool              # defaults to false (not null)
  #   error: string           # defaults to ""

# const
#   null* = NullClass(exists: true)
  # nothing* = Nothingclass(exists: true)
      