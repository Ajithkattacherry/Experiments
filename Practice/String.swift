//
//  String.swift
//  Practice
//
//  Created by Ajith Anthony on 5/24/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: 1. Palindrom string check
func isPalindrom(_ string: String) -> Bool {
    let strArray = Array(string)
    var i = 0
    let n = strArray.count
    while i < n/2 {
        if strArray[i] != strArray[(n - 1) - i] {
            return false
        }
        i += 1
    }
    return true
}

// MARK: 2. Palindrome Permutation
// If a set of characters can form a palindrome if at most one character
// occurs odd number of times and all characters occur even number of times.
func isPalindromPermutation(_ string: String) -> Bool {
    var hashMap = [Character: Int]()
    if string.isEmpty {
        return false
    }
    
    let strArray = Array(string)
    for char in strArray {
        if let count = hashMap[char] {
            hashMap[char] = count + 1
        } else {
            hashMap[char] = 1
        }
    }
    
    if (hashMap.values.filter { $0 > 2 }).count > 0 {
        return false
    }
    if (hashMap.values.filter { $0 == 1 }).count != 1 {
        return false
    }
    return true
}

// MARK:
func getAllComments(for adID: Int) {
    let data = ["1": "test comment1",
                "2": "test comment2",
                "3": "test comment3",
                "4": "test comment4",
                "5": "test comment5"]
    let keys = data.keys
    let values = data.values
    print(Array(keys)[adID])
    print(Array(values)[adID])
}
