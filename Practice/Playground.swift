//
//  Playground.swift
//  Practice
//
//  Created by Ajith Anthony on 12/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

func test() {
    let array = ["un","iq","ue"]
    var maxLengthString = ""
    for i in 0..<array.count {
        for j in i..<array.count {
            let string = String(array[i...j].joined())
            if !hasDuplicate(str: string) && maxLengthString.count < string.count {
                maxLengthString = string
            }
        }
    }
    print(maxLengthString)
}

func hasDuplicate(str: String) -> Bool {
    var dic = [Character: Int]()
    for char in str {
        if dic[char] != nil {
            return true
        }
        dic[char] = 0
    }
    return false
}
