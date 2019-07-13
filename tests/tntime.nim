import unittest

import nullable

suite "nullable nTime type":
  test "nTime assignment":
    let a: nTime = parseTime("2001-12-03", "yyyy-MM-dd", utc())
    check a == parseTime("2001-12-03", "yyyy-MM-dd", utc())
    var b: nTime = null(Time)
    check b.is_null
    check (b == null(Time)) == false  # null != null. See docs to understand why.
    b = nothing(Time)
    check b.is_nothing
  test "nTime error assignment":
    var c: nTime
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nTime printing":
#     let a: nTime = "-3"
#     check $a == -3
#     check repr(a) == "nTime(value:-3)"
#     let b: nTime = null(Time)
#     check $b == "null"
#     check repr(b) == "nTime(null)"
#     var c: nTime
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nTime(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnTime.nim\", line: 28, column: 5)\n])"
#     let d: nTime = nothing(Time)
#     check $d == "nothing"
#     check repr(d) == "nTime(nothing)"
#   test "nTime math operators":
#     let a: nTime = 7
#     let b: nTime = 3
#     let cnull: nTime = null(Time)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nTime).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nTime comparisons":
#     let a: nTime = 7
#     let b: nTime = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nTime state checks":
#     let a: nTime = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nTime = nothing(Time)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nTime = null(Time)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nTime
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
