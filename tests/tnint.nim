import unittest

import nullable

type
  User = object
    age: N[int]


suite "nullable N[int] type":
  test "N[int] assignment":
    let a: N[int] = -3
    check a == -3
    let b: N[int] = null(int)
    check b.is_null
    check (b == null(int)) == false  # null != null. See docs to understand why.
  test "N[int] error assignment":
    var c: N[int]
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
  test "object assignement":
    var a: User
    a = User(age: 33)
    check a.age == 33
    check a.age.get() == 33
    a = User(age: null(int))
    check a.age.is_null
  test "N[int] printing":
    let a: N[int] = "-3"
    check $a == -3
    check repr(a) == "N[int](-3)"
    let b: N[int] = null(int)
    check $b == "null"
    check repr(b) == "N[int](null)"
    var c: N[int]
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    # the following check isn't really possible because each testing machine will have a different path
    # check repr(c) == "N[int](@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnint.nim\", line: 40, column: 5)\n])"
    let d: N[int] = nothing(int)
    check $d == "nothing"
    check repr(d) == "N[int](nothing)"
  test "N[int] math operators":
    let a: N[int] = 7
    let b: N[int] = 3
    let cnull: N[int] = null(int)
    check (a + b) == 10
    check (a - b) == 4
    check (a * b) == 21
    check (a div b) == 2
    check (a div N[int](0)).has_error
    check (a + cnull).is_null
    check (a - cnull).is_null
    check (a * cnull).is_null
    check (a div cnull).has_error
  test "N[int] comparisons":
    let a: N[int] = 7
    let b: N[int] = 3
    check (a < b) == false
    check (a > b) == true
    check (a == b) == false
  test "N[int] state checks":
    let a: N[int] = -3
    check a.has_value() == true
    check a.is_nothing() == false
    check a.is_null() == false
    check a.has_error() == false
    let b: N[int] = nothing(int)
    check b.has_value == false
    check b.is_nothing == true
    check b.is_null == false
    check b.has_error == false
    let c: N[int] = null(int)
    check c.has_value == false
    check c.is_nothing == false
    check c.is_null == true
    check c.has_error == false
    var d: N[int]
    d.setError ValueError(msg: "something wrong")
    check d.has_value == false
    check d.is_nothing == false
    check d.is_null == false
    check d.has_error == true
