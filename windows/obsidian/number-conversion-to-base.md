# Converting a number to another base
There are multiple methods to convert a number in one base to another base.

## Two step
Suppose we want to convert the number 'n'(base k) to base 'p'.

1. Convert the number 'n' to base 10 using formula:
    ... + n^2 + n^1 + n^0 = x
2. Convert the decimal to target base k using formula:
    Keep repeating x/k and prepending remainder to result
