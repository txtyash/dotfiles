For the below Leetcode problem the time complexity was a summation series(read bottom of solution) which actually becomes `n(n-1)/2`, basically `O(n^2)`. This is called arithmetic summation series. Read more about this later...

```zig
// start 04:12 PM
// end: 04:32 PM
// Leetcode 48. Rotate Image
const std = @import("std");
const ArrayList = std.ArrayList;
const print = std.debug.print;
const expect = std.testing.expect;
const helpers = @import("./helpers.zig");
const reverse = std.mem.reverse;

pub fn solution(matrix: ArrayList(ArrayList(i32))) ArrayList(ArrayList(i32)) {
    // go through rows
    for (matrix.items, 0..) |row, r| {
        // go through their elements
        // we do r+1 to swap only iterate through triangle above the diagonal
        // this way we avoid swapping elements that are already in place
        // and also avoid re-swapping elements back to their original place
        for (r + 1..row.items.len) |c| {
            // take transpose by swapping elements
            matrix.items[r].items[c], matrix.items[c].items[r] = .{ matrix.items[c].items[r], matrix.items[r].items[c] };
        }
    }

    for (matrix.items) |row| {
        reverse(i32, row.items[0..]);
    }

    return matrix;
}

test "48: 3x3 matrix" {}

// Test case 2: 4x4 matrix
test "48: 4x4 matrix" {}

// time complexity O(r-1 + r-2 + r-3... r-r) for taking transpose + O(n^2) for reversing rows
// space complexity O(1)
```