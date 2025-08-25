const std = @import("std");
const Map = std.AutoHashMap;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;

pub fn isIsogram(str: []const u8) bool {
    var counter = [_]bool{false}**26;
    for(str) |character| {
        var index = std.ascii.toLower(character);
        if(index < 97 or index > 122) continue;
        index = index - 97;
        if(counter[index]) return false;
        counter[index] = true;
    }
    return true;
}

// TODO: Understand this bitset solution
// Alternative approach using bitset:
// For maximum performance, you could use a single u32 as a bitset:
// zigpub fn isIsogram(str: []const u8) bool {
//     var seen: u32 = 0;
//     for (str) |character| {
//         const c = std.ascii.toLower(character);
//         if (c < 97 or c > 122) continue;
//         const bit = @as(u32, 1) << @intCast(c - 97);
//         if (seen & bit != 0) return false;
//         seen |= bit;
//     }
//     return true;
// }
