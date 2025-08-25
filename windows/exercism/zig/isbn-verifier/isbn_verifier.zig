pub fn isValidIsbn10(s: []const u8) bool {
    var sum: usize = 0;
    var deduction: usize = 0; // Number to deduct from 10 to get the multiplier

    for (s) |c| {
        if (c == '-') continue;
        sum += if (c == 'X') 10 else (c - 48) * (10 - deduction);
        deduction += 1;
    }

    return deduction == 10 and sum % 11 == 0;
}
