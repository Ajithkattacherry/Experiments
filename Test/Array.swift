//
//  Array.swift
//  Practice
//
//  Created by Ajith Anthony on 5/23/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

//MARK: 1. SubArray in an array
func subarraySum(_ nums: [Int], _ k: Int) {
    var level = 0
    while level < nums.count {
        for i in 0..<nums.count {
            if i+level < nums.count {
                print(nums[i...(i+level)])
            }
        }
        level += 1
    }
}


//MARK: 2. Subarray Sum Equals K
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var level = 0
    var validSubset = 0
    while level < nums.count {
        for i in 0..<nums.count {
            if i+level < nums.count {
                if nums[i...(i+level)].reduce(0, +) == k {
                    validSubset += 1
                }
            }
        }
        level += 1
    }
    return validSubset
}

//MARK: 3. Remove Duplicates from a list
// Approach 1
func removeDuplicates1(from list: [Int]) -> [Int] {
    guard list.count > 0 else {
        return []
    }
    var resultArray = [Int]()
    for item in list {
        if !resultArray.contains(item) {
            resultArray.append(item)
        }
    }
    return resultArray
}

// Approach 2
func removeDuplicates2(from list: inout [Int]) -> [Int] {
    var i = 0
    var j = 1
    list = list.sorted()
    while j < list.count {
        if list[i] == list[j] {
            list.remove(at: j)
        } else {
            i += 1
            j += 1
        }
    }
    return list
}

// MARK: 4. Maximum Sum Contigous Subarray in an array
func maxSubArray(_ nums: [Int]) -> Int {
    var maxSum = 0
    if nums.count == 1 {
        maxSum = nums[0]
        return maxSum
    }
    
    var i = 0, k = 0, sum = 0
    for j in 0..<nums.count {
        if sum + nums[j] > nums[j] {
            sum += nums[j]
        } else {
            sum = nums[j]
            i = j
        }
        if sum > maxSum {
            maxSum = sum
            k = j
        }
    }
    print(nums[i...k])
    return maxSum
}

// MARK: 5. Move Zeroes to right end
// Given an array nums, write a function to move all 0's to the end of it while maintaining the
// relative order of the non-zero elements.
func moveZeroes(_ nums: inout [Int]) {
    var i = 0, j = 0
    while j < nums.count {
        if nums[i] == 0 {
            nums.append(nums.remove(at: i))
        } else {
            i += 1
        }
        j += 1
    }
}

// MARK: 6. Valid Parentheses
func isValid(_ s: String) -> Bool {
    let stringArray = Array(s)
    var stack = [String]()
     for char in stringArray {
         let rightChar = String(char)
         if rightChar == "(" || rightChar == "{" || rightChar == "[" {
             stack.append(rightChar)
         } else if rightChar == ")" || rightChar == "}" || rightChar == "]" {
             if stack.isEmpty {
                 return false
             } else if !isValidParanthesis(stack.removeLast(), rightChar) {
                 return false
             }
         }
     }
    return stack.isEmpty
}

func isValidParanthesis(_ left: String, _ right: String) -> Bool {
    switch left {
        case "(":
            return right == ")"
        case "{":
            return right == "}"
        case "[":
            return right == "]"
        default:
            return false
    }
}
