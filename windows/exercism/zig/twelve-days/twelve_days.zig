const std = @import("std");

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    const gifts: [12][]const u8 = .{ "Partridge in a Pear Tree", "Turtle Doves", "French Hens", "Calling Birds", "Gold Rings", "Geese-a-Laying", "Swans-a-Swimming", "Maids-a-Milking", "Ladies Dancing", "Lords-a-Leaping", "Pipers Piping", "Drummers Drumming" };
    const cardinal: [12][]const u8 = .{ "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth" };
    const numbers: [12][]const u8 = .{ "a", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve" };

    var stream = std.io.fixedBufferStream(buffer);
    var writer = stream.writer();

    for (start_verse..end_verse + 1) |verse| {
        writer.print("On the {s} day of Christmas my true love gave to me: ", .{cardinal[verse - 1]}) catch unreachable;
        var i: usize = verse;
        while (i > 0) : (i -= 1)
            writer.print("{s} {s}{s}", .{ numbers[i - 1], gifts[i - 1], if (i > 2) ", " else if (i > 1) ", and " else "" }) catch unreachable;
        writer.print(".{s}", .{if (verse < end_verse) "\n" else ""}) catch unreachable;
    }

    return stream.getWritten();
}

// Time complexity O(end_verse - start_verse)
// Space complexity O(end_verse - start_verse)
