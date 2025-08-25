const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    var base10: u32 = 0;
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    for (digits, 1..) |digit, i| {
        if (digit >= input_base) return ConversionError.InvalidDigit;
        base10 += digit * std.math.pow(u32, input_base, @truncate(digits.len - i));
    }

    var output = std.ArrayList(u32).init(allocator);
    defer output.deinit();

    if(digits.len == 0 or base10 == 0) try output.append(0);

    while (base10 > 0) : (base10 /= output_base)
        try output.insert(0, base10 % output_base);

    return output.toOwnedSlice();
}
