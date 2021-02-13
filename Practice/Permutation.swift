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
func permutations(_ n:Int, _ a: inout Array<Character>) {
    if n == 1 {
        print(String(a))
        return
    }
    for i in 0..<n-1 {
        permutations(n-1, &a)
        a.swapAt(n-1, (n%2 == 1) ? 0 : i)
    }
    permutations(n-1, &a)
}
