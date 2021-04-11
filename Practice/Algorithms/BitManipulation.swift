//
//  BitManipulation.swift
//  Practice
//
//  Created by Ajith Anthony on 6/26/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: Bit operation
func bitOperaton() {
    let a = 2, b = 4 // 0010, 0100
  
    print(a & b) // 0000
    print(a | b) // 0110  if
    print(a ^ b) // 0110  if exactly least one 1 -> 1, else 0
}

// MARK: Sum of numbers
func getSum(_ a: Int, _ b: Int) -> Int {
    let xor = a ^ b
    var and = a & b
    and = and << 1
    if xor & and != 0 {
        return getSum(xor, and)
    }
    return xor | and
}

// MARK: Check Number The Power Of 2
func checkNumberThePowerOf2(_ num: Int) -> Bool {
    let result = num & (num - 1)
    print(result)
    if result == 0 {
        return true
    }
    return false
}

// MARK: Number to binary
func numberToBinary() {
    func pad(string : String, toSize: Int) -> String {
      var padded = string
      for _ in 0..<(toSize - string.count) {
        padded = "0" + padded
      }
        return padded
    }

    let num = 22
    let str = String(num, radix: 2)
    print(str) // 10110
    let val = pad(string: str, toSize: 8)
    print(val)
}

// MARK: Single Number
// Given a non-empty array of integers, every element appears twice except for one. Find that single one.
func singleNumber(_ nums: [Int]) -> Int {
    var result = 0
    for i in 0..<nums.count {
        result ^= nums[i]
        print(result)
    }
    return result
}
