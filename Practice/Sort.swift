//
//  Sort.swift
//  Practice
//
//  Created by Ajith Anthony on 6/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

//MARK: Quick Sort

func quickSort(_ array: [Int]) -> [Int] {
    guard !array.isEmpty else {
        return []
    }
    
    let pivot = array[array.count / 2]
    let left = array.filter { $0 < pivot }
    let right = array.filter { $0 > pivot }
    let mid = array.filter { $0 == pivot }
    return quickSort(left) + mid + quickSort(right)
}
