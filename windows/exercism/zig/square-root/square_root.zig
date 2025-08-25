pub fn squareRoot(radicand: usize) usize {
    const radicand_cpy: f64 = @floatFromInt(radicand);
    var x: f64 = @floatFromInt( radicand / 2 );

    while (true) {
        x = (x + radicand_cpy / x) / 2;
        const y: usize = @intFromFloat(@round( x )); // BUG: Unable to convert to usize
        if (y * y == radicand) return y;
    }
}

// TODO: Pending
