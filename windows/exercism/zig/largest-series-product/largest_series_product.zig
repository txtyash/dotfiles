const std = @import("std");

pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    if (span > digits.len) return SeriesError.InsufficientDigits;
    if (span < 0) return SeriesError.NegativeSpan;
    if (span == 0 or digits.len == 0) return 1;

    var maxProduct: u64 = 0;
    var stepCount: usize = 0;
    var product: u64 = 1;
    var startIndex: usize = 0;

    for (0..digits.len) |i| {
        if (!std.ascii.isDigit(digits[i])) return SeriesError.InvalidCharacter;
        const digit = digits[i] - 48;

        if (digit == 0) {
            stepCount = 0;
            product = 1;
            continue;
        }

        if (stepCount == 0) startIndex = i;

        product *= digit;
        stepCount += 1;

        if (stepCount > span) {
            product /= (digits[startIndex] - 48);
            startIndex += 1;
        }

        if (stepCount >= span)
            maxProduct = std.mem.max(u64, &[2]u64{ maxProduct, product });
    }

    return maxProduct;
}


// Time complexity O(n)
// Space complexity O(1)
