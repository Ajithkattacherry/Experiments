//
//  Matrix.swift
//  Practice
//
//  Created by Ajith Anthony on 6/28/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: Set Matrix Zeroes
/***************************/
/*Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in-place.

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

// Solution with no extra memory
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

// MARK: Lucky Numbers in a Matrix
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
