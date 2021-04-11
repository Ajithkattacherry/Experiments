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


// MARK: Merge Sort
// Ref: https://www.youtube.com/watch?v=DfO089qWEE8&t=24s
func mergeSort(array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    
    let leftArray = Array(array[0..<array.count/2])
    let rigtArray = Array(array[array.count/2..<array.count])
    
    return merge(left: mergeSort(array: leftArray), right: mergeSort(array: rigtArray))
}

func merge(left: [Int], right: [Int]) -> [Int] {
    var mergeArray: [Int] = []
    var left = left
    var right = right
    
    while left.count > 0 && right.count > 0 {
        if left.first! < right.first! {
            mergeArray.append(left.removeFirst())
        } else {
            mergeArray.append(right.removeFirst())
        }
    }
    return mergeArray + left + right
}
