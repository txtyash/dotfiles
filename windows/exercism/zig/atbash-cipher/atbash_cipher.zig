const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;

pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    return encodeWithSpaces(allocator, s, true);
}

pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    return encodeWithSpaces(allocator, s, false);
}

pub fn encodeWithSpaces(allocator: mem.Allocator, s: []const u8, addSpace: bool) mem.Allocator.Error![]u8 {
    var result = std.ArrayList(u8).init(allocator);
    var charCount: usize = 0;

    for (s) |c| {
        if (!ascii.isAlphanumeric(c)) continue;
        if (addSpace and charCount == 5) {
            try result.append(' ');
            charCount = 0;
        }
        if (ascii.isAlphabetic(c)) {
            try result.append(219 - ascii.toLower(c));
        } else {
            try result.append(c);
        }
        charCount += 1;
    }

    return result.toOwnedSlice();
}
