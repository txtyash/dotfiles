const std = @import("std");
const Map = std.AutoHashMap;
const ArrayList = std.ArrayList;
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = Map(usize, void).init(allocator);
    defer multiples.deinit();
    var result: usize = 0;

    for (factors) |f| {
        if (f == 0) continue;
        var i = f;
        while (i < limit) : (i += f) {
            if (!multiples.contains(i)) result += i;
            try multiples.put(i, {});
        }
    }
    return result;
}
