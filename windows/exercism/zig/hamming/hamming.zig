pub const DnaError = error{ UnequalDnaStrands, EmptyDnaStrands };

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len == 0 or second.len == 0) return DnaError.EmptyDnaStrands;
    if (first.len != second.len) return DnaError.UnequalDnaStrands;

    var d: usize = 0;
    for (first, second) |f, s| d += @intFromBool(f != s);
    return d;
}
