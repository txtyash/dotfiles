const std = @import("std");
const mem = std.mem;
const ArrayList = std.ArrayList;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var result = ArrayList(u64).init(allocator);
    var value_copy: u64 = value;

    while (value_copy % 2 == 0) : (value_copy /= 2) try result.append(2);

    var factor: u64 = 3;
    while (factor * factor <= value_copy) : (factor += 2)
        while (value_copy % factor == 0) : (value_copy /= factor)
            try result.append(factor);

    if (value_copy > 1) try result.append(value_copy);

    return result.toOwnedSlice();
}

// Time complexity O(sqrt(n))
// Space complexity O(n)
// TODO: Revisit
