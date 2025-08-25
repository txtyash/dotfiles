---
id: 20250406132619
title: byte-addressability
tags: [fleeting]
date_created: 2025-04-06
time_created: 13:26
status: fleeting
---
# byte-addressability

There are 2 types of memory addressability:
1. Byte addressable
2. Word addressable

Memory is usually byte addressable meaning one pointer points to 1 byte of memory. The below picture depicts a memory address of 4bytes on a 32-bit architecture pointing to a single byte of memory.
![[byte-addressable-memory.excalidraw]]
Before understanding why we memory is byte-sized, let's understand how the 32-bit architecture works. 

On a 32-bit computer we can have memory addresses of 4 bytes, which is why such computers support only up to 4GB of memory. It can also support more with PAE(physical address extension), but I won't be discussing that.

**But why does the 32-bit architecture only support up to 4GB of memory?**
A 32-bit [[cpu|CPU]] can only read 4 bytes in a cycle, so it can only read a memory address of size 4 bytes at once. Using 4 bytes we can have up to 2^32 memory addresses. To understand how we can find how many values we can represent using `n` bits, refer to [[u16#range|finding range of u16 datatype]].

Now since we can represent **2^32** values with **32 bits**, we are able to have that many memory addresses and if each address pointed to a single byte of space then we can address **2^32**  bytes which is roughly 4 Giga Bytes.

**Now why do we only address a single byte with a memory address?**
*This will not be discussed in detail. This is just an overview*
1. If we addressed just 1 bit with each memory address then we can only address 512MB of memory using a 32bit architecture. And since a 32 bit processor can read 4 bytes in a cycle then why read just a single bit?
2. We can address 4 bytes of memory using a single memory address which will give us 16GB of memory on a 32-bit architecture but doing so will be less flexible.

## Related
- [[memory-alignment]]
- [[u16]]

---
*Fleeting notes should be processed within 1-2 days. Either convert to a permanent note or discard.*