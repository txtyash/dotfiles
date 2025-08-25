const std = @import("std");
const mem = std.mem;

pub const Relation = enum {
    unequal,
    equal,
    sublist,
    superlist,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    var result: Relation = .unequal;

    if (list_two.len == 0 or mem.containsAtLeast(i32, list_one, 1, list_two)) result = .superlist;
    if (list_one.len == 0 or mem.containsAtLeast(i32, list_two, 1, list_one))
        result = if (result == .superlist) .equal else .sublist;
    return result;
}
