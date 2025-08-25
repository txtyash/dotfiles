---
id: 20250402191717
title: memory-alignment
tags: [fleeting]
date_created: 2025-04-02
time_created: 19:17
status: fleeting
---
# memory-alignment

## Thought/Idea
memory alignment to determine the size of structs in systems programming languages.
So if I have a struct arranged this way:
```rust
// alignment 4 bytes
// Worst arrangement. Size required = 12 bytes
struct {
	a: bool,
	b: u32,
	c: u2,
}
// Best arrangement. Size required = 8 bytes
struct {
	a: bool,
	c: u2,
	b: u32,
}
```

## Possible Connections
[[zig]]

## Context/Source
https://www.youtube.com/watch?v=IroPQ150F6c&t=370s

---
*Fleeting notes should be processed within 1-2 days. Either convert to a permanent note or discard.*