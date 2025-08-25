pub const Plant = enum(u8) {
    clover = 'C',
    grass = 'G',
    radishes = 'R',
    violets = 'V',
};

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const i = 2 * (student[0] - 65); // get starting row index of the student's plants
    return .{
        @enumFromInt(diagram[i]),
        @enumFromInt(diagram[i + 1]),
        @enumFromInt(diagram[diagram.len / 2 + i + 1]),
        @enumFromInt(diagram[diagram.len / 2 + i + 2])
    };
}

// Time complexity O(1) does not grow with length of diagram
// Space complexity O(1)
