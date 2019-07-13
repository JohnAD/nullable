import unittest

import nullable

suite "nullable nOid type":
  test "nOid assignment":
    var a: nOid = parseOid("012345678901234567890123")
    check a == parseOid("012345678901234567890123")
    var b: nOid = null(Oid)
    check b.is_null
    check (b == null(Oid)) == false  # null != null. See docs to understand why.
    b = nothing(Oid)
    check b.is_nothing
    let c: nOid = "012345678901234567890123"
    check a == c
  test "nOid error assignment":
    var c: nOid
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
#   test "nOid printing":
#     let a: nOid = "-3"
#     check $a == -3
#     check repr(a) == "nOid(value:-3)"
#     let b: nOid = null(Oid)
#     check $b == "null"
#     check repr(b) == "nOid(null)"
#     var c: nOid
#     c.setError(ValueError(msg: "something wrong"))
#     check $c == "@[ValueError(something wrong)]"
#     check repr(c) == "nOid(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnOid.nim\", line: 28, column: 5)\n])"
#     let d: nOid = nothing(Oid)
#     check $d == "nothing"
#     check repr(d) == "nOid(nothing)"
#   test "nOid math operators":
#     let a: nOid = 7
#     let b: nOid = 3
#     let cnull: nOid = null(Oid)
#     check (a + b) == 10
#     check (a - b) == 4
#     check (a * b) == 21
#     check (a div b) == 2
#     check (a div 0.nOid).has_error
#     check (a + cnull).is_null
#     check (a - cnull).is_null
#     check (a * cnull).is_null
#     check (a div cnull).has_error
#   test "nOid comparisons":
#     let a: nOid = 7
#     let b: nOid = 3
#     check (a < b) == false
#     check (a > b) == true
#     check (a == b) == false
#   test "nOid state checks":
#     let a: nOid = -3
#     check a.has_value() == true
#     check a.is_nothing() == false
#     check a.is_null() == false
#     check a.has_error() == false
#     let b: nOid = nothing(Oid)
#     check b.has_value == false
#     check b.is_nothing == true
#     check b.is_null == false
#     check b.has_error == false
#     let c: nOid = null(Oid)
#     check c.has_value == false
#     check c.is_nothing == false
#     check c.is_null == true
#     check c.has_error == false
#     var d: nOid
#     d.setError ValueError(msg: "something wrong")
#     check d.has_value == false
#     check d.is_nothing == false
#     check d.is_null == false
#     check d.has_error == true
