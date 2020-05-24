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
