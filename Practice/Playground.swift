//
//  Playground.swift
//  Practice
//
//  Created by Ajith Anthony on 12/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

class Playground {
    
    func backTracking() {
        let first = ["A", "B", "C"]
        let second = ["D", "E", "F"]
        
        var combination = [String]()
        repeatLoop(index: 0, array: [first, second], carry: "", combination: &combination)
        print(combination)
    }
    
    func repeatLoop(index: Int, array: [[String]], carry: String, combination: inout [String]) {
        if index >= array.count {
            combination.append(carry)
            return
        }
        
        for i in 0..<array[index].count {
            repeatLoop(index: index + 1, array: array, carry: carry + array[index][i], combination: &combination)
        }
    }
}
