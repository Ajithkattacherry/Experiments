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
