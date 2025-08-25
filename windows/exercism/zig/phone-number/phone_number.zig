const std = @import("std");
const ascii = std.ascii;

pub fn clean(phrase: []const u8) ?[10]u8 {
    var result: [10]u8 = undefined;
    var i: usize = 0;

    for (phrase) |ch| {
        if ((ch == '1' and i == 0) or !ascii.isDigit(ch)) continue;
        if (i == 10) return null;
        result[i] = ch;
        i += 1;
    }

    if (i == 10 and result[0] > '1' and result[3] > '1')
        return result;

    return null;
}

// Time complexity O(n)
// Space compelxithy O(1)
