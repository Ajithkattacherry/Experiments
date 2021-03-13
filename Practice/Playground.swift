//
//  Playground.swift
//  Practice
//
//  Created by Ajith Anthony on 12/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

class Playground {
    
    class TreeNode<T> {
        var value: T?
        var left: TreeNode?
        var right: TreeNode?
        
        init(val: T, leftNode: TreeNode? = nil, rightTreeNode: TreeNode? = nil) {
            value = val
            left = leftNode
            right = rightTreeNode
        }
    }
    
    func setUp() -> TreeNode<String> {
        let vehicle = TreeNode(val: "vehicle")
        let twoWheeler = TreeNode(val: "twoWheeler")
        let fourWheeler = TreeNode(val: "fourWheeler")
        let pulsor = TreeNode(val: "pulsor")
        let hero = TreeNode(val: "hero")
        let maruthi = TreeNode(val: "maruthi")
        let tata = TreeNode(val: "tata")
        
        vehicle.left = twoWheeler
        vehicle.right = fourWheeler
        twoWheeler.left = pulsor
        twoWheeler.right = hero
        fourWheeler.left = maruthi
        fourWheeler.right = tata
        
        return vehicle
    }
    
    func getMatrix() -> [[Int]]{
        let matrix =
            [
                [1,1,1,1],
                [1,0,1,1],
                [1,0,1,1],
                [1,1,1,1]
            ]
        return matrix
    }
    
    
    func test() {
      var matrix = getMatrix()
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    updateRows(row: i, matrix: &matrix)
                    updateColumns(column: j, matrix: &matrix)
                }
            }
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                print("[\(i),\(j)]\n")
                if matrix[i][j] == -1 {
                    matrix[i][j] = 0
                }
            }
        }
        
        print(matrix)
    }
    
    func updateRows(row: Int, matrix: inout [[Int]]) {
        for i in 0..<matrix[row].count {
            if matrix[row][i] != 0 {
                matrix[row][i] = -1
            }
        }
    }
    
    func updateColumns(column: Int, matrix: inout [[Int]]) {
        for i in 0..<matrix[column].count {
            if matrix[i][column] != 0 {
                matrix[i][column] = -1
            }
        }
    }
    
    func sort(_ array: [Int]) -> [Int] {
        if array.isEmpty {
            return []
        }
        
        let pivot = array[array.count/2]
        let left = array.filter { $0 < pivot }
        let right = array.filter { $0 > pivot }
        return sort(left) + [pivot] + sort(right)
    }
    
    func traverse(root: TreeNode<String>?) {
        if root == nil {
            return
        }
        traverse(root: root?.left)
        traverse(root: root?.right)
        print(root?.value)
    }
    
    func bfs() {
        let root = setUp()
        var queue = [TreeNode<String>]()
        queue.append(root)
        while !queue.isEmpty {
            let node = queue.removeFirst()
            print(node.value)
            if let leftNode = node.left {
                queue.append(leftNode)
            }
            if let rightNode = node.right {
                queue.append(rightNode)
            }
        }
    }
    

}
