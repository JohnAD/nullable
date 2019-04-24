import src/nullable

# test assignment

var a: nint = 3
echo "3 = ", a
a = null
var c = a
echo "null = ", a
error(a, "something_wrong") # we can be fancy and pass real exceptions later
echo "err = ", a

var x: nint = 3
var y: int = x
echo "3 = ", $y
var z = 8.nint
echo "8 = ", $z

# test math

var b: nint = 4
echo "4 = ", b
b = b + to_nint(10)
echo "14 = ", b
b = b + to_nint(2)
echo "16 = ", b
b = to_nint(5) + b
echo "21 = ", b
a = a + to_nint(10) # should still be an error becase 'a' started as an error
echo "err = ", a

a = b - to_nint(2)
echo "19 = ", a
a = b * to_nint(2)
echo "42 = ", a
# a = b / 2   # should "round up" to 11
# echo "11 = ", a

# checks

if a.has_error():
  echo "a has an error"
if b.is_good():
  echo "b has a value"
if c.is_null():
  echo "c is null"
# 