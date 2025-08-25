const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var num_copy = num;
    var sum: u128 = 0;
    const length = (if (num > 0) std.math.log10(num) else 0) + 1;
    while (num_copy > 0) {
        sum += std.math.pow(u128, num_copy % 10, length);
        num_copy /= 10;
    }
    return sum == num;
}
// TODO: Checkout solution: <https://exercism.org/tracks/zig/exercises/armstrong-numbers/solutions/ZvontyFlugence>
