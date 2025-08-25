const std = @import("std");
const Allocator = std.mem.Allocator;
const BufSet = std.BufSet;
const eql = std.ascii.eqlIgnoreCase;
const toLower = std.ascii.toLower;

pub fn detectAnagrams(allocator: Allocator, word: []const u8, candidates: []const []const u8) !BufSet {
    var set = BufSet.init(allocator);

    for (candidates) |w| {
        if (!eql(word, w) and eql(&charCount(word), &charCount(w)))
            try set.insert(w);
    }
    return set;
}

pub fn charCount(word: []const u8) [26]u8 {
    var count: [26]u8 = .{0} ** 26;
    for (word) |c|
        count[toLower(c) - 97] += 1;
    return count;
}

// Time complexity O(n*m)
// n is length of candidates; m is length of each word
//
// Space complexity O(n)
// worst case it is entire length of candidates
// we have to store words in candidates plus an array of length 26 for each word
