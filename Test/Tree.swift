//
//  Tree.swift
//  Test
//
//  Created by Ajith Anthony on 5/10/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

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

// Minimum Depth of Binary Tree
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

// Maximum Depth of Binary Tree
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

// Range Sum of BST: Sum of node value between L & R
func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
    guard let root = root else {
        return 0
    }
    
    var sum = 0
    var queue: [TreeNode] = [root]
    while !queue.isEmpty {
        let node = queue.removeFirst()
        if node.val >= L && node.val <= R {
            sum += node.val
        }
        if let left = node.left {
            queue.append(left)
        }
        if let right = node.right {
            queue.append(right)
        }
    }
    return sum
}

// Merge two arays
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


// Search in a Binary Search Tree
func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    root?.preOrderTraversal(visit: {
        print($0.val)
    })
    
    return nil
}

