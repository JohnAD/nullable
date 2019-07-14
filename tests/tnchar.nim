import unittest

import nullable

suite "nullable nchar type":
  test "nchar assignment":
    var a: nchar = 'z'
    check a == 'z'
    var b: nchar = null(char)
    check b.is_null
    check (b == null(char)) == false  # null != null. See docs to understand why.
    b = nothing(char)
    check b.is_nothing
  test "nchar error assignment":
    var c: nchar
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nchar printing":
#     let a: nchar = "-3"
#     check $a == -3
#     check repr(a) == "nchar(value:-3)"
#     let b: nchar = null(char)
#     check $b == "null"
#     check repr(b) == "nchar(null)"
#     var c: nchar
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nchar(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnchar.nim\", line: 28, column: 5)\n])"
#     let d: nchar = nothing(char)
#     check $d == "nothing"
#     check repr(d) == "nchar(nothing)"
#   test "nchar math operators":
#     let a: nchar = 7
#     let b: nchar = 3
#     let cnull: nchar = null(char)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nchar).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nchar comparisons":
#     let a: nchar = 7
#     let b: nchar = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nchar state checks":
#     let a: nchar = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nchar = nothing(char)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nchar = null(char)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nchar
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
