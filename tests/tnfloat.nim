import unittest

import nullable

suite "nullable nfloat type":
  test "nfloat assignment":
    let a: nfloat = 3.14
    check a == 3.14
    var b: nfloat = null(float)
    check b.is_null
    check (b == null(float)) == false  # null != null. See docs to understand why.
    b = nothing(float)
    check b.is_nothing
  test "nfloat error assignment":
    var c: nfloat
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nfloat printing":
#     let a: nfloat = "-3"
#     check $a == -3
#     check repr(a) == "nfloat(value:-3)"
#     let b: nfloat = null(float)
#     check $b == "null"
#     check repr(b) == "nfloat(null)"
#     var c: nfloat
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nfloat(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnfloat.nim\", line: 28, column: 5)\n])"
#     let d: nfloat = nothing(float)
#     check $d == "nothing"
#     check repr(d) == "nfloat(nothing)"
#   test "nfloat math operators":
#     let a: nfloat = 7
#     let b: nfloat = 3
#     let cnull: nfloat = null(float)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nfloat).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nfloat comparisons":
#     let a: nfloat = 7
#     let b: nfloat = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nfloat state checks":
#     let a: nfloat = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nfloat = nothing(float)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nfloat = null(float)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nfloat
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
