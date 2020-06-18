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

// MARK: Search RotatedArray
func searchRotatedArray(_ array: [Int], _ target: Int) -> Int {
    guard !array.isEmpty else {
        return -1
    }
    
    var left = 0
    var right = array.count - 1
    
    while left < right {
        let mid = (left + right)/2
        if array[mid] == target {
            return mid
        } else if target <= array[mid] {
            right = mid
        } else {
            left = mid + 1
        }
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
