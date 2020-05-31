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

//MARK: 1. SubSet: SubSet from an array
// Approach 1
func allSubArray1(_ nums: [Int]) {
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

// Approach 2
func allSubArray2(_ nums: [Int]) {
    for i in 0..<nums.count {
        for j in i..<nums.count {
            print(nums[i...j])
        }
    }
}

//MARK: 2. SubArray: Subarray Sum Equals K
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var validSubset = 0
    for i in 0..<nums.count {
        for j in i..<nums.count {
            if nums[i...j].reduce(0, +) == k {
                validSubset += 1
            }
        }
    }
    return validSubset
}

func sumOfContinousSubArray(_ nums: [Int], _ k: Int) -> Bool {
    for i in 0..<nums.count {
        for j in i..<nums.count {
            if nums[i...j].reduce(0, +) == k {
                return true
            }
        }
    }
    return false
}

// MARK: 3. SubArray: Continuous Subarray Sum which can be a multple of K
/* Given a list of non-negative numbers and a target integer k, write a function to check if the array has a continuous subarray of size at least 2 that sums up to a multiple of k, that is, sums up to n*k where n is also an integer.
*/
func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    var result = [[Int]]()
    for i in 0..<nums.count {
        for j in i..<nums.count {
            if nums[i...j].reduce(0, +) % k == 0 {
                result.append(Array(nums[i...j]))
            }
        }
    }
    print(result)
    return !result.isEmpty
}

// MARK: 4. Subarray: Maximum Sum Contigous Subarray in an array
// Approach 1
func maxSubArray1(_ nums: [Int]) -> Int {
    var maxSum = 0
    var maxSumArray = [Int]()
    for i in 0..<nums.count {
        for j in i..<nums.count {
            let sum = nums[i...j].reduce(0, +)
            if sum > maxSum {
                maxSum = sum
                maxSumArray = Array(nums[i...j])
            }
        }
    }
    print(maxSumArray)
    return maxSum
}

// Approach 2
func maxSubArray2(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    var sum = nums[0]
    var maxSum = nums[0]
    for i in 1..<nums.count {
        let num = nums[i]
        print(num)
        sum = max(num, sum + num)
        print(sum)
        maxSum = max(maxSum, sum)
        print(maxSum)
        print("_______")
    }
    
    return maxSum
}

func maxSubArray3(_ nums: [Int]) -> Int {
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

// MARK: 9. Custom Sort String
/*S and T are strings composed of lowercase letters. In S, no letter occurs more than once.

S was sorted in some custom order previously. We want to permute the characters of T so that they match the order that S was sorted. More specifically, if x occurs before y in S, then x should occur before y in the returned string.
 
 Input:
 S: "kqep"
 T: "pekeq"
 Output: "kqeep"
 
 Input:
 S = "cba"
 T = "abcd"
 Output: "cbad"
 */

func customSortString(_ S: String, _ T: String) -> String {
    let sArray = Array(S)
    var tArray = Array(T)
    var resultString = [Character]()
    
    for char in sArray {
        while tArray.firstIndex(of: char) != nil { // loop until the repeated elemet is not found
            if tArray.contains(char) {
                resultString.append(char)
                guard let index = tArray.firstIndex(of: char) else {
                    continue
                }
                tArray.remove(at: index)
            }
        }
    }
    resultString.append(contentsOf: tArray)
    return String(resultString)
}


// MARK: 56. Merge Intervals
/*Given a collection of intervals, merge all overlapping intervals.

Example 1:

Input: [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
Idea: Once we sort the given intervals always the current min interval will be grater/less
      than previous interval. So if grater it can be treated as a new interval.
 */
func merge(_ intervals: [[Int]]) -> [[Int]] {
    var result = [[Int]]()
    guard intervals.count > 0 else {
        return result
    }
    let intervals = intervals.sorted { $0[0] < $1[0] }
    for interval in intervals {
        if result.count == 0 {
            result.append([interval[0], interval[1]])
        } else {
            let lastMax = result.last![1]
            let lastMin = result.last![0]
            if interval[0] > lastMax {
                result.append([interval[0], interval[1]])
            } else if interval[1] > lastMax {
                result.removeLast()
                result.append([lastMin, interval[1]])
            }
        }
    }
    return result
}
