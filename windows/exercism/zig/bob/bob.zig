const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

pub fn response(input: []const u8) []const u8 {
    const talk: []const u8 = mem.trim(u8, input, &ascii.whitespace);

    const isQuestion: bool = ascii.endsWithIgnoreCase(talk, "?");
    var isAllCaps: bool = true;
    var hasAlphabets: bool = false;

    for (talk) |c| {
        if (ascii.isAlphabetic(c)) {
            hasAlphabets = true;
            if (ascii.isLower(c)) isAllCaps = false;
        }
    }

    if (talk.len == 0) return "Fine. Be that way!";
    if (hasAlphabets) {
        if (isAllCaps and isQuestion) return "Calm down, I know what I'm doing!";
        if (isAllCaps) return "Whoa, chill out!";
    }
    if (isQuestion) return "Sure.";
    return "Whatever.";
}
