import unittest

import nullable

suite "nullable nbool type":
  test "nbool assignment":
    var a: nbool = true
    check a == true
    a = false
    check a == false
    var b: nbool = null(bool)
    check b.is_null
    check (b == null(bool)) == false  # null != null. See docs to understand why.
    b = nothing(bool)
    check b.is_nothing
  test "nbool error assignment":
    var c: nbool
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nbool printing":
#     let a: nbool = "-3"
#     check $a == -3
#     check repr(a) == "nbool(value:-3)"
#     let b: nbool = null(bool)
#     check $b == "null"
#     check repr(b) == "nbool(null)"
#     var c: nbool
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nbool(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnbool.nim\", line: 28, column: 5)\n])"
#     let d: nbool = nothing(bool)
#     check $d == "nothing"
#     check repr(d) == "nbool(nothing)"
#   test "nbool math operators":
#     let a: nbool = 7
#     let b: nbool = 3
#     let cnull: nbool = null(bool)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nbool).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nbool comparisons":
#     let a: nbool = 7
#     let b: nbool = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nbool state checks":
#     let a: nbool = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nbool = nothing(bool)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nbool = null(bool)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nbool
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
