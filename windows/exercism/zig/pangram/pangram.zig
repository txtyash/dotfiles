const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var counter = [_]bool{false}**26;
    for(str) |character| {
        var index = std.ascii.toLower(character);
        if(index < 97 or index > 122) continue;
        index = index - 97;
        counter[index] = true;
    }
    for(counter) |flag| {
        if(!flag) return false;
    }
    return true;
}

// TODO: Use a bitset solution like isogram.zig
// Can also check community solutions based on bitset
