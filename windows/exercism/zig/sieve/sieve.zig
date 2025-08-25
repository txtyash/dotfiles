const std = @import("std");

pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    var primeIndexes = std.bit_set.IntegerBitSet(limit + 1).initFull();
    primeIndexes.unset(0);
    primeIndexes.unset(1);

    var n: usize = 2;
    while (n * n <= limit) : (n += 1) {
        var i: usize = n * n;
        while (i <= limit) : (i += n) primeIndexes.unset(i);
    }

    var buf_i: usize = 0; // index for result buffer
    var set_i: u32 = 0; // index to check for set/unset bits
    while (set_i <= limit): (set_i += 1) {
        if (primeIndexes.isSet(set_i)) {
            buffer[buf_i] = set_i;
            buf_i += 1;
        }
    }

    return buffer[0..buf_i];
}

// TODO: Complexity analysis
