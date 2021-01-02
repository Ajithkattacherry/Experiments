//
//  Playground.swift
//  Practice
//
//  Created by Ajith Anthony on 12/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

class Playground {
    static let shared = Playground()
    var matrix = [[Int]]()
    
    func traverse() {
        matrix = [
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
}
