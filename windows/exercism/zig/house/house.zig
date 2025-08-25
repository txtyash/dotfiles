const std = @import("std");
const noun = [12][]const u8{ "house that Jack built", "malt", "rat", "cat", "dog", "cow with the crumpled horn", "maiden all forlorn", "man all tattered and torn", "priest all shaven and shorn", "rooster that crowed in the morn", "farmer sowing his corn", "horse and the hound and the horn" };
const verb = [11][]const u8{ "lay in", "ate", "killed", "worried", "tossed", "milked", "kissed", "married", "woke", "kept", "belonged to" };

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var stream = std.io.fixedBufferStream(buffer);
    var writer = stream.writer();

    for (start_verse..end_verse + 1) |verseNumber| {
        var i: usize = verseNumber;
        while (i > 0) : (i -= 1) {
            if (i == verseNumber) {
                writer.print("This is the {s}", .{noun[i - 1]}) catch unreachable;
            } else {
                writer.print(" that {s} the {s}", .{ verb[i - 1], noun[i - 1] }) catch unreachable;
            }
        }
        writer.print(".", .{}) catch unreachable;
        if (verseNumber != end_verse)
            writer.print("\n", .{}) catch unreachable;
    }

    return stream.getWritten();
}

// Time complexity O(n^2)
// for verse 1, 1 iteration, for verse 2 two iterations
// 1 + 2 + 3 ... = n(n+1)/2
// n is 12 in worst case

// Space complexity O(1)
// 372 characters in total
