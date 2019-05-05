import unittest

import nullable

suite "nullable nint type":
  test "nint assignment":
    let a: nint = -3
    check a == -3
    let b: nint = null
    check b == null
    var c: nint
    c.error("something wrong")
    check $c == "error(something wrong)"
  test "nint math operators":
    let a: nint = 7
    let b: nint = 3
    let cnull: nint = null
    check (a + b) == 10
    check (a - b) == 4
    check (a * b) == 21
    check (a div b) == 2
    check (a + cnull) == null
    check (a - cnull) == null
    check (a * cnull) == null
    check (a div cnull) == null
  test "nint comparisons":
    let a: nint = 7
    let b: nint = 3
    check (a < b) == false
    check (a > b) == true
    check (a == b) == false
  test "nint state checks":
    let a: nint = -3
    check a.is_good() == true
    check a.is_null() == false
    check a.has_error() == false
    let b: nint = null
    check b.is_good == false
    check b.is_null == true
    check b.has_error == false
    var c: nint
    c.error("something wrong")
    check c.is_good == false
    check c.is_null == false
    check c.has_error == true
