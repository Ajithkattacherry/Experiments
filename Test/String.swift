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

// MARK: 2.
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
