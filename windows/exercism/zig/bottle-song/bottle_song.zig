const std = @import("std");

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    var sb: u32 = start_bottles;
    var stream = std.io.fixedBufferStream(buffer);
    var writer = stream.writer();
    for (0..take_down) |td| {
        writer.print("{s} green {s} hanging on the wall,\n{s} green {s} hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be {s} green {s} hanging on the wall.", .{ toCardinal(sb, false), if (sb == 1) "bottle" else "bottles", toCardinal(sb, false), if (sb == 1) "bottle" else "bottles", toCardinal(sb - 1, true), if (sb == 2) "bottle" else "bottles" }) catch unreachable;
        if (td != take_down - 1) writer.print("\n\n", .{}) catch unreachable;
        sb -= 1;
    }

    return stream.getWritten();
}

pub fn toCardinal(n: u32, lower: bool) []const u8 {
    return switch (n) {
        10 => if (lower) "ten" else "Ten",
        9 => if (lower) "nine" else "Nine",
        8 => if (lower) "eight" else "Eight",
        7 => if (lower) "seven" else "Seven",
        6 => if (lower) "six" else "Six",
        5 => if (lower) "five" else "Five",
        4 => if (lower) "four" else "Four",
        3 => if (lower) "three" else "Three",
        2 => if (lower) "two" else "Two",
        1 => if (lower) "one" else "One",
        0 => if (lower) "no" else "No",
        else => unreachable,
    };
}

// Time complexity: O(n) n is equal to take_down
// Space complexity: O(m) m is output length
