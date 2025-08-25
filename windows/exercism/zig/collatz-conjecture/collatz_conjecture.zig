pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) ComputationError!usize {
    var num = number;
    var count: usize = 0;
    while (num > 1) {
        num = if (num % 2 == 0) num / 2 else (num * 3) + 1;
        count += 1;
    }

    return if(number > 0) count else ComputationError.IllegalArgument;
}
