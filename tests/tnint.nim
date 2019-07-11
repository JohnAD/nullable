import unittest

import nullable

suite "nullable nint type":
  test "nint assignment":
    let a: nint = -3
    check a == -3
    let b: nint = null(int)
    check b.is_null
    check (b == null(int)) == false  # null != null. See docs to understand why.
  test "nint error assignment":
    var c: nint
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    c.setError(IOError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong)]"
    c.setError(OSError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong), IOError(something wrong), OSError(something wrong)]"
  test "nint printing":
    let a: nint = "-3"
    check $a == -3
    check repr(a) == "nint(value:-3)"
    let b: nint = null(int)
    check $b == "null"
    check repr(b) == "nint(null)"
    var c: nint
    c.setError(ValueError(msg: "something wrong"))
    check $c == "@[ValueError(something wrong)]"
    check repr(c) == "nint(@[\n  ValueError(something wrong) at (filename: \"/home/johnad/Projects/nullable/tests/tnint.nim\", line: 28, column: 5)\n])"
    let d: nint = nothing(int)
    check $d == "nothing"
    check repr(d) == "nint(nothing)"
  test "nint math operators":
    let a: nint = 7
    let b: nint = 3
    let cnull: nint = null(int)
    check (a + b) == 10
    check (a - b) == 4
    check (a * b) == 21
    check (a div b) == 2
    check (a div 0.nint).has_error
    check (a + cnull).is_null
    check (a - cnull).is_null
    check (a * cnull).is_null
    check (a div cnull).has_error
  test "nint comparisons":
    let a: nint = 7
    let b: nint = 3
    check (a < b) == false
    check (a > b) == true
    check (a == b) == false
  test "nint state checks":
    let a: nint = -3
    check a.has_value() == true
    check a.is_nothing() == false
    check a.is_null() == false
    check a.has_error() == false
    let b: nint = nothing(int)
    check b.has_value == false
    check b.is_nothing == true
    check b.is_null == false
    check b.has_error == false
    let c: nint = null(int)
    check c.has_value == false
    check c.is_nothing == false
    check c.is_null == true
    check c.has_error == false
    var d: nint
    d.setError ValueError(msg: "something wrong")
    check d.has_value == false
    check d.is_nothing == false
    check d.is_null == false
    check d.has_error == true
