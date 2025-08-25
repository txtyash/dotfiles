# Coding Problems and Optimal Solutions

## Problem 1: Easy - Binary to DNA Encoding

### Statement
For encoding an even-length binary string into a sequence of A, T, C, and G, we iterate from left to right and replace the characters as follows:

* 00 is replaced with A
* 01 is replaced with T
* 10 is replaced with C
* 11 is replaced with G

Given a binary string S of length N (N is even), find the encoded sequence.

### Optimal Solution

```typescript
function encodeBinaryToDNA(s: string): string {
    let result = "";
    
    // Process string in chunks of 2
    for (let i = 0; i < s.length; i += 2) {
        const chunk = s.substring(i, i + 2);
        
        switch (chunk) {
            case "00":
                result += "A";
                break;
            case "01":
                result += "T";
                break;
            case "10":
                result += "C";
                break;
            case "11":
                result += "G";
                break;
        }
    }
    
    return result;
}

// Alternative one-liner using regex
function encodeBinaryToDNARegex(s: string): string {
    return s.replace(/00/g, "A")
            .replace(/01/g, "T")
            .replace(/10/g, "C")
            .replace(/11/g, "G");
}

// Usage example
function processInput() {
    const testCases = [
        "0011",     // Expected: "AG"
        "010011",   // Expected: "TAG"
        "00011011"  // Expected: "AATG"
    ];
    
    testCases.forEach(test => {
        console.log(`Input: ${test} -> Output: ${encodeBinaryToDNA(test)}`);
    });
}
```

**Time Complexity:** O(n) where n is the length of the string  
**Space Complexity:** O(n) for the result string

---

## Problem 2: Moderate - Flight Bag Problem

### Statement
Chef has 3 bags that she wants to take on a flight. They weigh A, B, and C kgs respectively. She wants to check-in exactly two of these bags and carry the remaining one bag with her.

The airline restrictions say that the total sum of the weights of the bags that are checked-in cannot exceed D kgs and the weight of the bag which is carried cannot exceed E kgs. Find if Chef can take all the three bags on the flight.

### Input Format
* The first line of the input: T (number of test cases)
* Each test case contains single line of input: Five space-separated integers A, B, C, D, E.

### Output Format
For each test case, output in a single line answer "YES" if chef can take all three bags with her or "NO"

### Optimal Solution

```typescript
function canTakeAllBags(a: number, b: number, c: number, d: number, e: number): string {
    const bags = [a, b, c];
    
    // Try each bag as the carry-on bag
    for (let i = 0; i < 3; i++) {
        const carryBag = bags[i];
        const checkedWeight = bags.reduce((sum, weight, index) => 
            index !== i ? sum + weight : sum, 0
        );
        
        // Check if this configuration satisfies both constraints
        if (carryBag <= e && checkedWeight <= d) {
            return "YES";
        }
    }
    
    return "NO";
}

// More explicit version for clarity
function canTakeAllBagsExplicit(a: number, b: number, c: number, d: number, e: number): string {
    // Try carrying bag A, checking bags B and C
    if (a <= e && (b + c) <= d) return "YES";
    
    // Try carrying bag B, checking bags A and C
    if (b <= e && (a + c) <= d) return "YES";
    
    // Try carrying bag C, checking bags A and B
    if (c <= e && (a + b) <= d) return "YES";
    
    return "NO";
}

// Complete solution with input processing
function solveBagProblem() {
    // Example test cases
    const testCases = [
        [5, 10, 15, 20, 12],  // Expected: YES (carry 10, check 5+15=20)
        [10, 10, 10, 15, 5],  // Expected: NO (no bag ≤ 5 to carry)
        [3, 4, 5, 10, 6]      // Expected: YES (carry 5, check 3+4=7)
    ];
    
    testCases.forEach((testCase, index) => {
        const [a, b, c, d, e] = testCase;
        const result = canTakeAllBags(a, b, c, d, e);
        console.log(`Test Case ${index + 1}: ${result}`);
    });
}
```

**Time Complexity:** O(1) - constant time as we only check 3 possibilities  
**Space Complexity:** O(1) - constant space

---

## Problem 3: Hard - Binary Tree Serialization/Deserialization

### Statement
Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

### Optimal Solution

```typescript
class TreeNode {
    val: number;
    left: TreeNode | null;
    right: TreeNode | null;
    
    constructor(val?: number, left?: TreeNode | null, right?: TreeNode | null) {
        this.val = val ?? 0;
        this.left = left ?? null;
        this.right = right ?? null;
    }
}

class Codec {
    // Serialize using preorder traversal with delimiters
    serialize(root: TreeNode | null): string {
        const result: string[] = [];
        
        function dfs(node: TreeNode | null): void {
            if (node === null) {
                result.push("null");
                return;
            }
            
            result.push(node.val.toString());
            dfs(node.left);
            dfs(node.right);
        }
        
        dfs(root);
        return result.join(",");
    }
    
    // Deserialize using preorder traversal
    deserialize(data: string): TreeNode | null {
        const values = data.split(",");
        let index = 0;
        
        function buildTree(): TreeNode | null {
            if (index >= values.length || values[index] === "null") {
                index++;
                return null;
            }
            
            const node = new TreeNode(parseInt(values[index]));
            index++;
            
            node.left = buildTree();
            node.right = buildTree();
            
            return node;
        }
        
        return buildTree();
    }
}

// Alternative implementation using level-order (BFS) approach
class CodecBFS {
    serialize(root: TreeNode | null): string {
        if (!root) return "";
        
        const result: string[] = [];
        const queue: (TreeNode | null)[] = [root];
        
        while (queue.length > 0) {
            const node = queue.shift()!;
            
            if (node === null) {
                result.push("null");
            } else {
                result.push(node.val.toString());
                queue.push(node.left);
                queue.push(node.right);
            }
        }
        
        return result.join(",");
    }
    
    deserialize(data: string): TreeNode | null {
        if (!data) return null;
        
        const values = data.split(",");
        const root = new TreeNode(parseInt(values[0]));
        const queue: TreeNode[] = [root];
        let i = 1;
        
        while (queue.length > 0 && i < values.length) {
            const node = queue.shift()!;
            
            if (values[i] !== "null") {
                node.left = new TreeNode(parseInt(values[i]));
                queue.push(node.left);
            }
            i++;
            
            if (i < values.length && values[i] !== "null") {
                node.right = new TreeNode(parseInt(values[i]));
                queue.push(node.right);
            }
            i++;
        }
        
        return root;
    }
}

// Usage example
function testSerialization() {
    const codec = new Codec();
    
    // Create a test tree:     1
    //                       /   \
    //                      2     3
    //                           / \
    //                          4   5
    const root = new TreeNode(1);
    root.left = new TreeNode(2);
    root.right = new TreeNode(3);
    root.right.left = new TreeNode(4);
    root.right.right = new TreeNode(5);
    
    const serialized = codec.serialize(root);
    console.log("Serialized:", serialized);
    
    const deserialized = codec.deserialize(serialized);
    const reSerialized = codec.serialize(deserialized);
    console.log("Re-serialized:", reSerialized);
    console.log("Match:", serialized === reSerialized);
}
```

**Time Complexity:** 
- Serialize: O(n) where n is the number of nodes
- Deserialize: O(n) where n is the number of nodes

**Space Complexity:** 
- Serialize: O(n) for the recursion stack and result array
- Deserialize: O(n) for the recursion stack and constructed tree

---

## Key Insights

1. **Problem 1**: Simple string processing with pattern matching. The switch statement approach is more readable than multiple if statements.

2. **Problem 2**: Brute force approach is optimal here since we only have 3 bags to consider. We try each bag as the carry-on and check if constraints are satisfied.

3. **Problem 3**: Both DFS (preorder) and BFS (level-order) approaches work well. DFS is more intuitive and uses less additional space for the queue, while BFS might be easier to understand for some developers.

Each solution prioritizes correctness, readability, and optimal time/space complexity for the given constraints.