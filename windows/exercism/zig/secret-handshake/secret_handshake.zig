const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    const binary: []u8 = try std.fmt.allocPrint(allocator, "{b}", .{number});
    defer allocator.free(binary);
    mem.reverse(u8, binary);
    var result = std.ArrayList(Signal).init(allocator);
    defer result.deinit();
    var result_array: []Signal = undefined;
    var reverse_array: bool = false;

    for (binary, 0..) |ch, i| {
        if (ch == '0') continue;
        if (i == 4) {
            reverse_array = true;
            break;
        }
        try result.append(@enumFromInt(i));
    }
    result_array = try result.toOwnedSlice();
    if (reverse_array) mem.reverse(Signal, result_array);

    return result_array;
}

// Time complexity: O(4)
// Space complexity: O(4)
// TODO: Check solution: https://exercism.org/tracks/zig/exercises/secret-handshake/solutions/szczescie
