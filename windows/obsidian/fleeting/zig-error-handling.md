---
id: 20250309015654
title: zig-error-handling
tags: [fleeting]
date_created: 2025-03-09
time_created: 01:56
status: fleeting
---
# zig-error-handling

## Thought/Idea
* Error sets coerce to their supersets
* Error union is formed by combining an error set and another type using `!`
* keyword `noreturn`. It is the type of return, while(true)...
* In this function signature:
  `fn createFile() !void` The function returns an error union & the error set is inferred.
* Zig does not let us ignore error unions using `_`. We must unwrap it using try, catch or if:
  `_ x = if(y == AllocationError.OutOfMemory) 1 else y;`
* Error sets can be merged using `||`:
  ```zig
  const AWSError = error { ServerDown, InvalidCredentials };
  const DBError = error { ServerDown, BadRequest };
  const GeneralError = AWSError || DBError;
  ```
* Zig has a builtin global error set called `anyerror`. It is superset of all errors.

## Possible Connections
[[zig]],

## Context/Source
While studying zig

---
*Fleeting notes should be processed within 1-2 days. Either convert to a permanent note or discard.*