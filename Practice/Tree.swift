//
//  Tree.swift
//  Test
//
//  Created by Ajith Anthony on 5/10/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation


/**
 class TreeNode {
     var value: Int
     var left: TreeNode?
     var right: TreeNode?
     
     init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
         self.value = value
         self.left = left
         self.right = right
     }
     
     func traverse(_ visit: (TreeNode) -> Void) {
         visit(self)
         left?.traverse(visit)
         right?.traverse(visit)
     }
 }

 class Solution {
     func visitAllNodes(_ root: TreeNode) {
         root.traverse {
             print($0.value)
         }
     }
 }

 let root = TreeNode(value: 10)
 let left1 = TreeNode(value: 1)
 let right1 = TreeNode(value: 11)
 root.left = left1
 root.right = right1
 Solution().visitAllNodes(root)
 */

/*********** Alernative approach ***********
 class Solution {
     func inorderTraversal(_ root: TreeNode?) -> [Int] {
         var list = [Int]()
         travserse(root, values: &list)
         print(list)
         return list
     }
     
     func travserse(_ root: TreeNode?, values: inout [Int]) {
         guard let root = root else {
             return
         }
         travserse(root.left, values: &values)
         values.append(root.val)
         travserse(root.right, values: &values)
     }
 }
 */

public class TreeNodeDFS {
    var value: Int?
    var children: [TreeNodeDFS]?
    init(_ value: Int, children: [TreeNodeDFS]?) {
        self.value = value
        self.children = children
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    func preOrderTraversal(visit: (TreeNode) -> Void) {
        visit(self)
        self.left?.preOrderTraversal(visit: visit)
        self.right?.preOrderTraversal(visit: visit)
    }
    
    func postOrderTraversal(visit: (TreeNode) -> Void) {
        self.left?.postOrderTraversal(visit: visit)
        self.right?.postOrderTraversal(visit: visit)
        visit(self)
    }
    
    func inOrderTraversal(visit: (TreeNode) -> Void) {
        self.left?.inOrderTraversal(visit: visit)
        visit(self)
        self.right?.inOrderTraversal(visit: visit)
    }
    
    func breathFirstSearch(visit: (TreeNode) -> Void) {
        var queue = [self]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            visit(node)
            if let left = node.left {
                queue.append(left)
            }
            
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    
    func depthFirstSearch(visit: (TreeNode) -> Void) {
        visit(self)
        self.left?.depthFirstSearch(visit: visit)
        self.right?.depthFirstSearch(visit: visit)
    }
}

/*Approach 2*/
class BreadthFirstSearch {
    func bfsTraversal(_ root: TreeNode?) {
        var queue = [TreeNode]()
        guard let root = root else { return }
        queue.append(root)
        breadthFirstSearch(&queue)
    }
    
    func breadthFirstSearch(_ queue: inout [TreeNode]) {
        let node = queue.removeFirst()
        print(node.val) // Collecting Node values
        if let left = node.left {
            queue.append(left)
        }

        if let right = node.right {
            queue.append(right)
        }
        
        // Boundary condition. Perform this until the queue is empty
        if !queue.isEmpty {
            breadthFirstSearch(&queue)
        }
    }
}

class DepthFirstSearch {
    func dfsTraversal(_ root: TreeNodeDFS?) {
        guard let root = root else { return }
        dfs(root)
    }
    
    func dfs(_ node: TreeNodeDFS?) {
        print(node?.value ?? 0)
        if node?.children?.isEmpty ?? true {
            return
        }
        node?.children?.forEach { dfs($0)}
    }
}

//MARK: 1. Minimum Depth of Binary Tree
func minDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    
    var minLevel = 0
    var queue: [TreeNode] = [root]
    while !queue.isEmpty {
        minLevel += 1
        let count = queue.count
        for _ in 0..<count {
            let node = queue.removeFirst()
            if let leftNode = node.left {
               queue.append(leftNode)
            }
            if let rightNode = node.right {
                queue.append(rightNode)
            }
            if node.right == nil && node.left == nil {
                return minLevel
            }
        }
    }
    return minLevel
}

//MARK: 2. Maximum Depth of Binary Tree
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    
    var queue = [root]
    var maxLevel = 0
    while !queue.isEmpty {
        maxLevel += 1
        let count = queue.count
        for _ in 0..<count {
            let node = queue.removeFirst()
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    return maxLevel
}

//MARK: 3. Range Sum of BST: Sum of node value between L & R
func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
    guard let root = root else {
        return 0
    }
    
    var sum = 0
    root.inOrderTraversal {
        if $0.val >= L && $0.val <= R {
            sum += $0.val
        }
    }
    return sum
}

//MARK: 4. Merge two arays
func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
       guard let t1 = t1 else {
           return t2
       }
       
       guard let t2 = t2 else {
           return t1
       }
       
       let t3 = TreeNode(t1.val + t2.val)
       t3.left = mergeTrees(t1.left, t2.left)
       t3.right = mergeTrees(t1.right, t2.right)
       return t3
   }


//MARK: 5. Search in a Binary Search Tree
func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    root?.preOrderTraversal(visit: {
        print($0.val)
    })
    
    return nil
}

//MARK: 6. Minimum Distance Between BST Nodes
func minDiffInBST(_ root: TreeNode?) -> Int {
    var array = [Int]()
    root?.inOrderTraversal {
        array.append($0.val)
    }
    var result = Int.max
    for i in 1 ..< array.count {
        result = min(result, array[i] - array[i-1])
    }
    return result
}

//MARK: 7. Kth Smallest Element in a BST
func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    var array = [Int]()
    root?.inOrderTraversal {
        array.append($0.val)
    }
    array = array.sorted { $0 < $1 }
    return array[k-1]
}

//MARK: 8. Second Minimum Node In a Binary Tree
func findSecondMinimumValue(_ root: TreeNode?) -> Int {
    var array = [Int]()
    root?.inOrderTraversal {
        array.append($0.val)
    }
    array = array.sorted { $0 < $1 }
    if array.count == 1 {
        return -1
    }
    var i = 1
    while array[i] <= array[i - 1] {
        if i < array.count - 1 {
            i += 1
        } else {
            return -1
        }
    }
    return array[i]
}

//MARK: 9. Binary Tree Paths
/*
 Given a binary tree, return all root-to-leaf paths.

 Note: A leaf is a node with no children.

 Example:

 Input:

    1
  /   \
 2     3
  \
   5

 Output: ["1->2->5", "1->3"]
*/
func binaryTreePaths(_ root: TreeNode?) -> [String] {
    var result = [String]()
    var stack = [String]()
    root?.traverse(&stack, &result)
    return result
}

extension TreeNode {
    func traverse(_ stack: inout [String], _ result: inout [String]) {
        stack.append("\(self.val)")
        if self.left == nil && self.right == nil {
            result.append(stack.joined(separator: "->"))
        }
        self.left?.traverse(&stack, &result)
        self.right?.traverse(&stack, &result)
        stack.removeLast()
    }
}

// MARK: 10. Sorted Array to Binary Tree
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    guard !nums.isEmpty else { return nil }
    let root = bst(nums, start: 0, end: nums.count-1)
    return root
}

private func bst(_ nums: [Int], start: Int, end: Int) -> TreeNode? {
    guard start <= end else {
        return nil
    }
    
    let rootIndex = start + (end - start)/2
    let rootNode = TreeNode(nums[rootIndex])
    rootNode.left = bst(nums, start: start, end: rootIndex-1)
    rootNode.right = bst(nums, start: rootIndex+1, end: end)
    
    return rootNode
}

// MARK: 11. Maximum Binary Tree
/*
 Input: [3,2,1,6,0,5]
 Output: return the tree root node representing the following tree:

       6
     /   \
    3     5
     \    /
      2  0
        \
         1
 */
func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
    guard nums.count > 0 else { return nil }
    
    var maxNum = 0
    var maxIdx = 0
    for (idx, num) in nums.enumerated() {
        if num > maxNum {
            maxNum = num
            maxIdx = idx
        }
    }
    
    let root = TreeNode(maxNum)
    root.left = constructMaximumBinaryTree(Array(nums[0..<maxIdx]))
    root.right = constructMaximumBinaryTree(Array(nums[(maxIdx + 1)..<nums.count]))
    return root
}

class InsertIntoBST {
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        let node = getInsertionNode(root, value: val)
        node?.left = TreeNode(val)
        return root
    }
    
    func getInsertionNode(_ node: TreeNode?, value: Int) -> TreeNode? {
        guard let treeNode = node else { return node }
        if treeNode.left == nil && treeNode.right == nil {
             return treeNode
        }
        if value > treeNode.val {
            return getInsertionNode(treeNode.right, value: value)
        } else {
            return getInsertionNode(treeNode.left, value: value)
        }
    }
}
