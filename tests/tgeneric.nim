import unittest

import nullable

suite "nullable generics":
  test "generic assignment":
    type
      User = object
        # name: nstring
        age: int
    var u: N[User]

    u = User(age: 22)
    check $u == "(age: 22)"
    check repr(u) == "N[User](age: 22)"

    u = nothing(User)
    check $u == "nothing"
    check repr(u) == "N[User](nothing)"

    u = null(User)
    check $u == "null"
    check repr(u) == "N[User](null)"

    u.setError ValueError(msg: "test")
    check $u == "@[ValueError(test)]"
    check repr(u) == "N[User]@[\n  ValueError(test) at (filename: \"tgeneric.nim\", line: 25, column: 5)\n]"
