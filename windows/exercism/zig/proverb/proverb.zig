const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var poem = std.ArrayList([]u8).init(allocator);
    if (words.len == 0) return poem.toOwnedSlice();
    for (0..words.len - 1) |i| {
        const line = try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{ words[i], words[i + 1] });
        try poem.append(line);
    }
    const line = try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
    try poem.append(line);
    return poem.toOwnedSlice();
}
