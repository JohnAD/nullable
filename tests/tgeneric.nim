import unittest

import nullable

suite "nullable generics":
  test "generic assignment":
    type
      User = object
        # name: nstring
        age: nint
    var u: Nullable[User]

    u = User(age: 22)
    check $u == "(age: 22)"
    check repr(u) == "Nullable[User](age: 22)"

    u = nothing(User)
    check $u == "nothing"
    check repr(u) == "Nullable[User](nothing)"

    u = null(User)
    check $u == "null"
    check repr(u) == "Nullable[User](null)"

    u.setError ValueError(msg: "test")
    check $u == "error(ValueError, test)"
