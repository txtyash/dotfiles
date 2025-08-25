const std = @import("std");
pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    var sum: u64 = 0;
    for (1..n) |factor| {
        if (n % factor == 0) sum += factor;
    }

    if (sum < n) return Classification.deficient;
    if (sum == n) return Classification.perfect;
    return Classification.abundant;
}
