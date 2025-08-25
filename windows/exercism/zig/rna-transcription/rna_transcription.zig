const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const result: []u8 = try allocator.alloc(u8, dna.len);
    for(dna, 0..) |c, i| {
        result[i] = switch (c) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => unreachable,
        };
    }
    return result;
}
