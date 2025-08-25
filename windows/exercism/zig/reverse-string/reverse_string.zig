const std = @import("std");

pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    @memcpy(buffer, s);
    std.mem.reverse(u8, buffer);
    return buffer;
}
