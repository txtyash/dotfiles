const std = @import("std");

pub fn isValid(s: []const u8) bool {
    // Validate input
    var length: usize = 0;
    for (s) |c| {
        if (std.ascii.isWhitespace(c)) continue;
        if (!std.ascii.isDigit(c)) return false;
        length += 1;
    }
    if (length < 2) return false;

    // if length is even then double the even index else double the odd index character
    var sum: usize = 0;
    var i: usize = s.len - 1;
    var dbl = false;
    while (i >= 0) : (i -= 1) {
        if (!std.ascii.isDigit(s[i])) continue;
        const n = s[i] - 48;
        if (dbl) {
            sum += if (n * 2 > 9) n * 2 - 9 else n * 2;
        } else {
            sum += n;
        }
        dbl = !dbl;
        if(i == 0) break;
    }
    return sum % 10 == 0;
}
