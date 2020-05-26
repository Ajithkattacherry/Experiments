//
//  Array.swift
//  Practice
//
//  Created by Ajith Anthony on 5/23/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

//*****CATEGORY******
//**1. SubArray

//MARK: 1. SubArray: SubArray in an array
func allSubArrayList(_ nums: [Int], _ k: Int) {
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


//MARK: 2. SubArray: Subarray Sum Equals K
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

// MARK: 3. SubArray: Continuous Subarray Sum which can be a multple of K
/* Given a list of non-negative numbers and a target integer k, write a function to check if the array has a continuous subarray of size at least 2 that sums up to a multiple of k, that is, sums up to n*k where n is also an integer.
*/
func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    var level = 1
    var i = 0
    var result = [[Int]]()
    for _ in 0..<nums.count {
       while i + level < nums.count {
            if nums[i...i+level].reduce(0, +) % k == 0 {
                result.append(Array(nums[i...i+level]))
            }
            i += 1
       }
        level += 1
        i = 0
    }
    return !result.isEmpty
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

//MARK: 5. Remove Duplicates from a list
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

// MARK: 6. Move Zeroes to right end
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

// MARK: 7. Valid Parentheses
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

// MARK: 8. Permutation of an Ineger array
func permute(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var nums = nums
    recurse(0, &nums, &result)
    return result
}

func recurse(_ first: Int, _ nums: inout [Int], _ result: inout [[Int]]) {
    if first == nums.count {
        result.append(nums)
        return
    }
    for index in first..<nums.count {
        nums.swapAt(first, index)
        recurse(first+1, &nums, &result)
        nums.swapAt(first, index)
    }
}
