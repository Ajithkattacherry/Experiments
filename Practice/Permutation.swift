//
//  BackTracking.swift
//  Practice
//
//  Created by Ajith Anthony on 6/26/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: Permutations of a string using Heap's algorithm
// Explanation: Heap's algorithm(https://www.geeksforgeeks.org/heaps-algorithm-for-generating-permutations/) is nicely efficient, the deeper point is that it walks through the entire array and swaps every possible pair.
// var arr = Array("ABC")
// permutations(arr.count, &arr)
func permutations(_ n:Int, _ a: inout [Character]) {
    if n == 1 {
        print(String(a))
    } else {
        for i in 0..<n-1 {
            permutations(n-1, &a)
            a.swapAt(n-1, (n%2 == 0) ? i : 0)
        }
        permutations(n-1, &a)
    }
}

// Another approach
func permuteNums(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var nums = nums
        recurseValue(0, &nums, &result)
        return result
    }
    
    func recurseValue(_ first: Int, _ nums: inout [Int], _ result: inout [[Int]]) {
        if first == nums.count {
            result.append(nums)
            return
        }
        for index in first..<nums.count {
            nums.swapAt(first, index)
            recurseValue(first+1, &nums, &result)
            nums.swapAt(first, index)
        }
    }
