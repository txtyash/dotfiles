pub const ChessboardError = error{IndexOutOfBounds};
const std = @import("std");

pub fn square(index: usize) ChessboardError!u64 {
    return if (index > 0 and index < 65) std.math.pow(usize, 2, index - 1) else ChessboardError.IndexOutOfBounds;
}

pub fn total() u64 {
    return comptime addAllGrains();
}

pub fn addAllGrains() u64 {
    var sum = 0;
    for (0..64) |i| sum += std.math.pow(usize, 2, i);
    return sum;
}

// TODO: Check out this solution <https://exercism.org/tracks/zig/exercises/grains/solutions/fguasch>
