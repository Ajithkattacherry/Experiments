//
//  BackTracking.swift
//  Practice
//
//  Created by Ajith Anthony on 6/26/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: Permutations of a string
// var arr = Array("ABC")
// permutations(arr.count, &arr)
func permutations(_ n: Int, _ a: inout [Character], output: inout [String]) {
    if n == 1 {
        output.append(String(a))
    } else {
        for i in 0..<n-1 {
            permutations(n-1, &a, output: &output)
            a.swapAt(n-1, (n%2 == 0) ? i : 0)
        }
        permutations(n-1, &a, output: &output)
    }
}
