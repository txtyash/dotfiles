const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, sentence: []const u8) mem.Allocator.Error![]u8 {
    var acronym = std.ArrayList(u8).init(allocator);
    var words = std.mem.tokenizeAny(u8, sentence, " -_");
    while (words.next()) |word| {
        const ch = std.ascii.toUpper(word[0]);
        try acronym.append(ch);
    }
    return acronym.toOwnedSlice();
}
