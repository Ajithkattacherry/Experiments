//
//  Search.swift
//  Practice
//
//  Created by Ajith Anthony on 6/17/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: Binary search
func binarySrarch(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count
    var mid = 0
    while left < right {
        mid = (left + right) / 2
        if target == nums[mid] {
            return mid
        } else if target < nums[mid] {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return -1
}

// MARK: Search Rotated Sorted Array
func searchRotatedArray(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 0 else { return -1 }
    var left = 0
    var right = nums.count - 1
    var mid = 0
    while left + 1 < right {
        mid = left + (right - left) / 2
        if nums[mid] == target {
            return mid
        }
        if nums[mid] > nums[left] {
            if nums[left] <= target && target <= nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            if nums[mid] <= target && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    if nums[left] == target {
        return left
    }
    
    if nums[right] == target {
        return right
    }
    
    return -1
}

// MARK: longest Common Prefix
func longestCommonPrefix1(_ strs: [String]) -> String {
    var prefix = strs.first ?? ""
    for str in strs {
        prefix = str.commonPrefix(with: prefix)
    }
    return prefix
}

func longestCommonPrefix2(_ strs: [String]) -> String {
    var prefix = strs.first ?? ""
    for str in strs {
        let prfixArray = Array(prefix)
        let strArray = Array(str)
        let limit = min(strArray.count, prfixArray.count)
        var i = 0
        while i < limit {
            if prfixArray[i] != strArray[i] {
                prefix = String(prfixArray[0..<i])
                break
            }
            i += 1
        }
    }
    return prefix
}
