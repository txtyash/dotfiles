---
id: 20250315192742
title: quick-sort
tags:
  - fleeting
  - algorithm
date_created: 2025-03-15
time_created: 19:27
status: fleeting
---
Quick sort is a sorting algorithm that sorts the array with the time complexity of `O(logn)`.

## Algorithm

When using this algorithm to sort an array we need to choose a pivot which is any element from the array we are sorting. Choosing a better pivot can give us a better time complexity, but for sorting small arrays we will just choose the last element as the pivot.

We will use an iterative approach because we are coding up the solution in [[zig]]. This will reduce the code complexity as compared to the recursive solution. 

1. To simulate recursion we will maintain a stack that stores ranges. This stack will store portions of the array after the partition. We will pop the topmost range from the stack to sort it.
2. Push the entire array range to the stack initially, which is `(0, 7)`.
3. For execution we pop a range from the stack and sort it. So we pop `(0, 7)`. 
   **NOTE**: To continue execution we pop a range from the stack and sort it, which could generate more ranges. We continue until the stack is empty.
4. Suppose we have the array `[8, 4, 1, 5, 7, 2, 6, 3]`(length 8), then we choose a pivot, let's say the last element `3`(index 7)
5. Sort the array around the pivot to: `[1, 2, 3, 8, 4, 5, 7, 6]`.
6. Partition around element `3`(index 2)
7. Push the partitions `(0, 2)` & `(3, 7)` to the stack.
8. To continue the execution we pop a range from the stack and perform sorting on it

## Solution



---
*Fleeting notes should be processed within 1-2 days. Either convert to a permanent note or discard.* 
