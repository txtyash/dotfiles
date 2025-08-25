---
id: 20250309132855
title: leetcode-31-next-permutation
tags: [leetcode]
date_created: 2025-03-09
time_created: 13:28
---
# leetcode-31-next-permutation
**Link:**  <https://leetcode.com/problems/next-permutation>

## Approach

### Brute force
Using a brute force approach would require going through all possible permutations of the array. So if we have the array `[1, 8, 7, 6]`, then the next permutation is `[6, 1, 7, 8]`. We will have to generate all of these permutations using this recursive approach:
```typescript
function permutations(list: number[]): number[][] {
    if (list.length <= 1) return [list];
    
    let result: number[][] = [];
    
    for (let i = 0; i < list.length; i++) {
        // generate permutations of elements except the current one
        let remaining: number[] = list.slice(0, i).concat(list.slice(i+1));
        
        for (const p of permutations(remaining)) {
            result.push([list[i], ...p]);
        }
    }
    
    return result;
```
#### Time Complexity
We iterate over `n` elements and generate a permutation `n` times, here the complexity would be `n*T(n-1)` where `T(n-1)` is the complexity of generating permutations for `n-1` elements. We also need to account for `remaining` array we create which is a `O(n)` operation. Now the complexity is `n*T(n-1)*n`.

Next we need to add the complexity for the number of permutations generated for `n-1` elements is `(n-1)!` and we do the push using spread, it has a time complexity of `O(n)`, this gives us a complexity of `n*(n-1)!`.

`T(n) = n*T(n-1)*n + n*(n-1)!`
`T(n) = n*n! + n*(n-1)!`
`T(n) = n*n!` is our final time complexity.

#### Space Complexity
_Understand the space complexity in depth_

### Approach 2
_Discuss other optimal approach_
#### Time Complexity
_Understand the time complexity in depth_
#### Space Complexity
_Understand the space complexity in depth_