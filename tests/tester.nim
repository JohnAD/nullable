import nullable

# test assignment

var a: nint = 3
echo "3 = ", a
a = null
var c = a
echo "null = ", a
error(a, "something_wrong") # we can be fancy and pass real exceptions later
echo "err = ", a

# test math

var b: nint = 4
echo "4 = ", b
b = b + 10
echo "14 = ", b
b = b + 2
echo "16 = ", b
b = 5 + b
echo "21 = ", b
a = a + 10 # should still be an error becase 'a' started as an error
echo "err = ", a

# checks

if a.has_error():
  echo "a has an error"
if b.is_good():
  echo "b has a value"
if c.is_null():
  echo "c is null"
# 