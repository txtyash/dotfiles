const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    const result = try allocator.dupe(u8, text);

    for (result) |*c| {
        if (ascii.isAlphabetic(c.*)) {
            if (ascii.isLower(c.*))
                c.* = (c.* - 'a' + shiftKey) % 26 + 'a';
            if (ascii.isUpper(c.*))
                c.* =  (c.* - 'A' + shiftKey) % 26 + 'A';
        }
    }

    return result;
}

// Time Complexity O(n)
// Space complexity O(n) Because we need to create a copy?
// TODO: Revisit
