//
//  BackTracking.swift
//  Practice
//
//  Created by Ajith Anthony on 3/18/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: 1. Back tracking
func backTracking() {
    let first = ["A", "B", "C"]
    let second = ["D", "E", "F"]
    
    var combination = [String]()
    // Index represents the no of items in the array
    repeatLoop(index: 0, array: [first, second], carry: "", combination: &combination)
    print(combination)
}

func repeatLoop(index: Int, array: [[String]], carry: String, combination: inout [String]) {
    if index >= array.count {
        combination.append(carry)
        return
    }
    
    // This will help to loop through each item in the individual array
    for i in 0..<array[index].count {
        repeatLoop(index: index + 1, array: array, carry: carry + array[index][i], combination: &combination)
    }
}

// MARK: 2. Letter Combinations of a Phone Number'
/// Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.
/// Return the answer in any order.
func letterCombinations(_ digits: String) -> [String] {
    guard !digits.isEmpty else { return [] }
    
    let maps: [Character: String] = ["2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno", "7": "pqrs", "8": "tuv", "9": "wxyz"]
    
    var strings = [String]()
    for d in digits {
        if let s = maps[d] {
            strings.append(s)
        }
    }
    
    var combinations = [String]()
    letterCombinations(0, strings, "", &combinations)
    return combinations
}

func letterCombinations(_ index: Int, _ strings: [String], _ carry: String, _ combinations: inout [String]) {
    if index >= strings.count {
        combinations.append(carry)
        return
    }
    
    for c in strings[index] {
        letterCombinations((index+1), strings, (carry + String(c)), &combinations)
    }
}
