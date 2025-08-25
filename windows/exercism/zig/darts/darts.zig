pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{ .x = x_coord, .y = y_coord };
    }

    pub fn score(self: Coordinate) usize {
        const d = @sqrt(self.x * self.x + self.y * self.y); // distance

        if (d <= 1) return 10;
        if (d <= 5) return 5;
        if (d <= 10) return 1;

        return 0;
    }
};
