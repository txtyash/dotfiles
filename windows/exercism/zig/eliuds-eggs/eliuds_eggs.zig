pub fn eggCount(number: usize) usize {
    var num = number;
    var count: usize = 0;
    while (num > 0) {
        num &= (num - 1);
        count += 1;
    }
    return count;
}

// TODO: The set bits can be counted with @popcount() but understand the above Brian Kerninghan's algorithm
