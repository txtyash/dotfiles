const std = @import("std");
const mem = std.mem;

pub fn prime(allocator: mem.Allocator, number: usize) !usize {
    var limit = number * (@log(number) + @log(@log(number)));
    var n = 2;
    var set = std.bit_set.IntegerBitSet(limit).initFull();
    while(n*n <= limit): (n += 1) {
        var i = n * n;
        while(i <= limit): (i += n) set.unset(i);
    }
    var it = set.iterator(.{});
    var setBitCount = 0;
    while(it.next()): (setBitCount += 1) {
        if(setBitCount) return i;
    }
}

// Use sieve algorithm to find the primes
// Use a bitset to mark non-primes
// loop till?
