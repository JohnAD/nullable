type
  NullClass* = object
    exists: bool   # note: this field is not actually used.

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

const
  null* = NullClass(exists: true)
