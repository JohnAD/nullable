import unittest

import nullable

suite "nullable N[bool] type":
  test "N[bool] assignment":
    var a: N[bool] = true
    check a == true
    a = false
    check a == false
    var b: N[bool] = null(bool)
    check b.is_null
    # TODO: Error: parallel 'fields' iterator does not work for 'case' objects
    # var c = null(bool)
    # check (c != b)  # null != null. See docs to understand why.
    b = nothing(bool)
    check b.is_nothing
  test "N[bool] error assignment":
    var c: N[bool]
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "N[bool] printing":
#     let a: N[bool] = "-3"
#     check $a == -3
#     check repr(a) == "N[bool](value:-3)"
#     let b: N[bool] = null(bool)
#     check $b == "null"
#     check repr(b) == "N[bool](null)"
#     var c: N[bool]
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "N[bool](@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tN[bool].nim\", line: 28, column: 5)\n])"
#     let d: N[bool] = nothing(bool)
#     check $d == "nothing"
#     check repr(d) == "N[bool](nothing)"
#   test "N[bool] math operators":
#     let a: N[bool] = 7
#     let b: N[bool] = 3
#     let cnull: N[bool] = null(bool)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.N[bool]).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "N[bool] comparisons":
#     let a: N[bool] = 7
#     let b: N[bool] = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "N[bool] state checks":
#     let a: N[bool] = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: N[bool] = nothing(bool)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: N[bool] = null(bool)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: N[bool]
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
