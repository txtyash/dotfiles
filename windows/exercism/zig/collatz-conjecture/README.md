# Collatz Conjecture

Welcome to Collatz Conjecture on Exercism's Zig Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Introduction

One evening, you stumbled upon an old notebook filled with cryptic scribbles, as though someone had been obsessively chasing an idea.
On one page, a single question stood out: **Can every number find its way to 1?**
It was tied to something called the **Collatz Conjecture**, a puzzle that has baffled thinkers for decades.

The rules were deceptively simple.
Pick any positive integer.

- If it's even, divide it by 2.
- If it's odd, multiply it by 3 and add 1.

Then, repeat these steps with the result, continuing indefinitely.

Curious, you picked number 12 to test and began the journey:

12 ➜ 6 ➜ 3 ➜ 10 ➜ 5 ➜ 16 ➜ 8 ➜ 4 ➜ 2 ➜ 1

Counting from the second number (6), it took 9 steps to reach 1, and each time the rules repeated, the number kept changing.
At first, the sequence seemed unpredictable — jumping up, down, and all over.
Yet, the conjecture claims that no matter the starting number, we'll always end at 1.

It was fascinating, but also puzzling.
Why does this always seem to work?
Could there be a number where the process breaks down, looping forever or escaping into infinity?
The notebook suggested solving this could reveal something profound — and with it, fame, [fortune][collatz-prize], and a place in history awaits whoever could unlock its secrets.

[collatz-prize]: https://mathprize.net/posts/collatz-conjecture/

## Instructions

Given a positive integer, return the number of steps it takes to reach 1 according to the rules of the Collatz Conjecture.

## Error handling

For this exercise you must add an error set `ComputationError` that contains the `IllegalArgument` error.
Remember to make it public!
The `steps` function must return `ComputationError.IllegalArgument` when its input is equal to zero.

Later exercises will usually omit explicit instructions like this.
In general, Exercism expects you to read the test file when implementing your solution.

For more details about errors in Zig, see:

- [Learning Zig - Errors][learning-zig-errors]
- [Ziglings - Exercise 21][ziglings-exercise-21]
- [Zighelp - Errors][zighelp-errors]

[learning-zig-errors]: https://www.openmymind.net/learning_zig/language_overview_2/#errors
[zighelp-errors]: https://zighelp.org/chapter-1/#errors
[ziglings-exercise-21]: https://codeberg.org/ziglings/exercises/src/commit/0d46acfa02d0c29fdfb3651e82a77284dd8f2e00/exercises/021_errors.zig

## Source

### Created by

- @massivelivefun

### Contributed to by

- @ee7

### Based on

Wikipedia - https://en.wikipedia.org/wiki/Collatz_conjecture