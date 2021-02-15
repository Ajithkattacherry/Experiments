//
//  Matrix.swift
//  Practice
//
//  Created by Ajith Anthony on 6/28/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

/***********************************/
// MARK: Set Matrix Zeroes
/***************************/
/* Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in-place.

Example 1:

Input:
[
  [1,1,1],
  [1,0,1],
  [1,1,1]
]
Output:
[
  [1,0,1],
  [0,0,0],
  [1,0,1]
]*/

// MARK: 1. Solution with no extra memory
func setZeroes(_ matrix: inout [[Int]]) {
    // Support functions
    func updateRows(_ row: Int, _ matrix: inout [[Int]]) {
        for i in 0..<matrix[row].count {
            if matrix[row][i] != 0 {
                matrix[row][i] = -10000
            }
        }
    }

    func updateColumns(_ column: Int, _ matrix: inout [[Int]]) {
        for i in 0..<matrix.count {
            if matrix[i][column] != 0 {
                matrix[i][column] = -10000
            }
        }
    }
    
    // Find all the places with value zero and update the corresponding places with -10000 exept 0
    // This will update all the location with -10000 instead of 0
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if matrix[i][j] == 0 {
                updateRows(i, &matrix)
                updateColumns(j, &matrix)
            }
        }
    }
    
    // Finally replace all the -1 with 0
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if matrix[i][j] == -10000 {
                matrix[i][j] = 0
            }
        }
    }
}

/***************************/
// MARK: 2. Lucky Numbers in a Matrix
/***************************/
/*
Given a m * n matrix of distinct numbers, return all lucky numbers in the matrix in any order.
A lucky number is an element of the matrix such that it is the minimum element in its row and maximum in its column.

Example 1:

Input: matrix =
 [[3,7,8],
  [9,11,13],
  [15,16,17]]
Output: [15]
Explanation: 15 is the only lucky number since it is the minimum in its row and the maximum in its column*/
func luckyNumbers (_ matrix: [[Int]]) -> [Int] {
    var result = [Int]()
    for i in 0..<matrix.count {
        var min = Int.max
        var column = 0
        // Finding the min value from a row and keepong the column number
        for j in 0..<matrix[i].count {
            if matrix[i][j] < min {
                min = matrix[i][j]
                column = j
            }
        }
        // Finding the max value from the column of the min value
        let max = getMaxValue(from: column, matrix: matrix)
        
        // If both are same, lucky number!
        if min == max {
            result.append(min)
        }
    }
    return result
}

func getMaxValue(from column: Int, matrix: [[Int]]) -> Int {
    var max = 0
    for k in 0..<matrix.count {
        if matrix[k][column] > max {
            max = matrix[k][column]
        }
    }
    return max
}

/***********************************/
// MARK: 3. Number of isLands using DFS
/*
 Given an m x n 2d grid map of '1's (land) and '0's (water), return the number of islands.
 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.
 You may assume all four edges of the grid are all surrounded by water.

 Input: grid = [
   ["1","1","1","1","0"],
   ["1","1","0","1","0"],
   ["1","1","0","0","0"],
   ["0","0","0","0","0"]
 ]
 Output: 1

 */
/***********************************/

func setupMatrix() -> [[Int]] {
    var matrix = [[Int]]()
    let row1 = [1,1,0,1]
    let row2 = [1,0,1,0]
    let row3 = [0,1,0,1]
    matrix.append(row1)
    matrix.append(row2)
    matrix.append(row3)
    return matrix
}

func matrixDFS() {
    var matrix = setupMatrix()
    var noOfIslands = 0
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            noOfIslands += dfs(i: i, j: j, matrix: &matrix)
        }
    }
    print(noOfIslands)
}

func dfs(i: Int, j: Int, matrix: inout [[Int]]) -> Int {
    if i < 0 || j < 0 || i >= matrix.count || j >= matrix[i].count || matrix[i][j] == 0 {
        return 0
    }
    // Set visited nodes as 0
    matrix[i][j] = 0
    
    // Visit in all directs until we find a 0.
    // If top, bottom, left and right node are 0, we found an island
    dfs(i: i, j: j+1, matrix: &matrix)
    dfs(i: i, j: j-1, matrix: &matrix)
    dfs(i: i-1, j: j, matrix: &matrix)
    dfs(i: i+1, j: j, matrix: &matrix)
    return 1
}

/***********************************/
// MARK: 4. Spiral Matrix
/***********************************/
func traverse() {
    // Setup
    var matrix = [[Int]]()
    let row1 = [1,2,3,11]
    let row2 = [4,5,6,12]
    let row3 = [7,8,9,44]
    matrix.append(row1)
    matrix.append(row2)
    matrix.append(row3)
    
    var top = 0
    var left = 0
    var bottom = matrix.count
    var right = matrix[0].count
    var result = [Int]()
    var direction = 1
    
    while top<bottom && left<right {
        if direction == 1 {
            for i in left..<right {
                result.append(matrix[top][i])
            }
            top += 1
            direction = 2
        } else if direction == 2 {
            for i in top..<bottom {
                result.append(matrix[i][right-1])
            }
            right -= 1
            direction = 3
        } else if direction == 3 {
            for i in (left..<right).reversed() {
                result.append(matrix[bottom-1][i])
            }
            bottom -= 1
            direction = 4
        } else if direction == 4 {
            for i in (top..<bottom).reversed() {
                result.append(matrix[i][left])
            }
            left += 1
            direction = 1
        }
    }
    print(result)
}

/***************************************/
// MARK: 5. Find the sourounded regions
// https://www.youtube.com/watch?v=FoVhnqN0B28
/*
 130. Surrounded Regions
 Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.

 A region is captured by flipping all 'O's into 'X's in that surrounded region.

 Example:

 X X X X
 X O O X
 X X O X
 X O X X
 After running your function, the board should be:

 X X X X
 X X X X
 X X X X
 X O X X
 */
/***************************************/
func souroundedRegions() {
    var matrix = [
        [1,1,1,1,1,1],
        [1,0,0,0,0,1],
        [1,1,0,1,1,1],
        [1,0,1,0,1,0]
    ]
    
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if (i == 0 || j == 0 || i == matrix.count-1 || j == matrix[i].count-1) && matrix[i][j] == 0 {
                findTheSurroundedRegions(i: i, j: j, matrix: &matrix)
            }
            
        }
    }
    updateSurroundedRegions(matrix: &matrix)
    print(matrix)
}

func findTheSurroundedRegions(i: Int, j: Int, matrix: inout [[Int]]) {
    if i >= 0 && j >= 0 && i <= matrix.count-1 && j <= matrix[i].count-1 && matrix[i][j] == 0 {
        matrix[i][j] = 9
        findTheSurroundedRegions(i: i+1, j: j, matrix: &matrix)
        findTheSurroundedRegions(i: i-1, j: j, matrix: &matrix)
        findTheSurroundedRegions(i: i, j: j-1, matrix: &matrix)
        findTheSurroundedRegions(i: i, j: j+1, matrix: &matrix)
    }
}

func updateSurroundedRegions(matrix: inout [[Int]]) {
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if matrix[i][j] == 0 {
                matrix[i][j] = 1
            } else if matrix[i][j] == 9 {
                matrix[i][j] = 0
            }
        }
    }
}
