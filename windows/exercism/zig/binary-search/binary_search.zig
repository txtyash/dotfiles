pub fn binarySearch(T: type, target: T, items: []const T) ?usize {
    var l: usize = 0;
    var r: usize = items.len;

    while (l < r) {
        const m = l + (r - l) / 2;
        if (target == items[m]) return m;
        if (target > items[m]) {
            l = m + 1;
        } else {
            r = m;
        }
    }
    return null;
}
