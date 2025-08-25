pub fn isLeapYear(year: u32) bool {
    return year % 400 == 0 or (year % 100 != 0 and year % 4 == 0);
}
