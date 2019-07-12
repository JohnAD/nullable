import unittest

import nullable

suite "nullable nstring type":
  test "nstring assignment":
    let a: nstring = "larry"
    check a == "larry"
    var b: nstring = null(string)
    check b.is_null
    check (b == null(string)) == false  # null != null. See docs to understand why.
    b = nothing(string)
    check b.is_nothing
  test "nstring error assignment":
    var c: nstring
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nstring printing":
#     let a: nstring = "-3"
#     check $a == -3
#     check repr(a) == "nstring(value:-3)"
#     let b: nstring = null(string)
#     check $b == "null"
#     check repr(b) == "nstring(null)"
#     var c: nstring
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nstring(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnstring.nim\", line: 28, column: 5)\n])"
#     let d: nstring = nothing(string)
#     check $d == "nothing"
#     check repr(d) == "nstring(nothing)"
#   test "nstring math operators":
#     let a: nstring = 7
#     let b: nstring = 3
#     let cnull: nstring = null(string)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nstring).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nstring comparisons":
#     let a: nstring = 7
#     let b: nstring = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nstring state checks":
#     let a: nstring = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nstring = nothing(string)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nstring = null(string)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nstring
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
