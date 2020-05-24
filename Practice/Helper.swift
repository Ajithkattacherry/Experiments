//
//  Helper.swift
//  Test
//
//  Created by Ajith Anthony on 5/18/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    let stringArray = ["45 Apple",
                       "32 Pineapple",
                       "21 Orange",
                       "43 Banana",
                       "23 Cherry",
                       "21 Kivi",
                       "74 Coconut"]
    var dictionary = [String: String]()
    
    
    // MARK: 1. STRING
    /*********************************
     ********STRING OPERATIONS********
     *********************************/
    func testStringOperations() {
        //1. String to Char array
        let sample = "Sample"
        let charArray = Array(sample)
        print(charArray)
    }
    
    func testStringArrayToDictionary() {
        for string in stringArray {
            let data = string.split(separator: " ")
            dictionary[String(data[0])] = String(data[1])
        }
        print(dictionary)
    }
    
    func testStringContains() {
        let string = "This is a sample search test"
        print(string.contains("test"))
    }
    
    func testStringTrimmingCharacters() {
        let string = "This is a big day"
        print(string.trimmingCharacters(in: .whitespaces))
    }
    
    func testComponentsSeparatedBy() {
        // Split always returns a string array
        let string = " This is  a  big  day "
        let array = string.components(separatedBy: " ")
        print(array)
        // OUTPUT: ["", "This", "is", "", "a", "", "big", "", "day", ""]
    }
    
    func testStringSplitByChar() {
        // Split always returns a substring array
        let string = " This is  a  big  day "
        let array = string.split(separator: " ")
        print(array)
        // OUTPUT: ["This", "is", "a", "big", "day"]
    }
    
    // MARK: 2. DICTIONARY
    /*********************************
     ********DICTIONARY OPERATIONS*****
     *********************************/
    func testAllKeys() {
        testStringArrayToDictionary()
        let dicKeys = dictionary.keys
        let dicValues = dictionary.values
        print("Dic Keys: \(dicKeys)")
        print("Dic Keys: \(dicValues)")
    }
    
    func testSortByKey() {
        testStringArrayToDictionary()
        let sortedDictionary = dictionary.sorted { $0.0 > $1.0 }
        print(sortedDictionary)
    }
    
    func testSortByValue() {
        testStringArrayToDictionary()
        let sortedDictionary = dictionary.sorted { $0.1 > $1.1 }
        print(sortedDictionary)
    }
    
    func testAllKeysAndValue() {
        testStringArrayToDictionary()
        var keys = [String]()
        var values = [String]()
        for (key, value) in dictionary {
            keys.append(key)
            values.append(value)
        }
        print(keys)
        print(values)
    }
    
    func testFilterDictionary() {
        testStringArrayToDictionary()
        var data = dictionary.filter { $0.value == "Coconut" }
        print(data)
        data = dictionary.filter { $0.key == "23" }
        print(data)
    }
    
    func testFilterDicioanryKeys() {
        // Filter keys based on condition
        let subKeys = dictionary.keys.filter { Int($0) ?? 0 > 40 }
        print("keys: \(Array(subKeys))")
        print("\(Array(subKeys).contains("74"))")
    }
    
    func testCreateDictionaryByGrouping() {
        let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
        var studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
        print(studentsByLetter)
        // ["A": ["Abena", "Akosua"], "E": ["Efua"], "K": ["Kofi", "Kweku"]]
        
        studentsByLetter = Dictionary(grouping: stringArray, by: { value in
            let key = value.split(separator: " ").last!
            return key.first!
        })
        print(studentsByLetter)
        //["K": ["21 Kivi"], "O": ["21 Orange"], "P": ["32 Pineapple"], "B": ["43 Banana"], "C": ["23 Cherry", "74 Coconut"], "A": ["45 Apple"]]
    }
    
    // MARK: 3. ARRAY
    /*********************************
     ********ARRAY OPERATIONS*****
     *********************************/
    // Array Slice will give you the sub array fro an array
    // It will keep the indices of the parent array
    func testArraySlice() {
        let array = [1,3,4,5,6,7]
        let slice: ArraySlice = array[2...5]
        print(slice)
        print(slice.firstIndex(of: 4) ?? 0)
    }
    
    func testArraySort() {
        let array = [1,9,3,5,4,1,6,7]
        print(array.sorted { $0 < $1 })
        // Output: [1, 1, 3, 4, 5, 6, 7, 9]
    }
    
    func testArrayReduce() {
        let primes: Set = [2, 3, 5, 7]
        let primesSum = primes.reduce(0, +)
        print(primesSum)
        // Output:17
    }
    
    func testArrayMap() {
        let primes: Set = [2, 3, 5, 7]
        let primeStrings = primes.sorted().map(String.init)
        print(primeStrings)
        // Output: ["2", "3", "5", "7"]
    }
    
    func testArrayFilter() {
        let primes: Set = [2, 3, 5, 7]
        let result = primes.filter { $0 > 4 }
        print(result)
        // Output:[7, 5]
    }
    
    // MARK: 4. SET
    /*********************************
     ********SET OPERATIONS*****
     *********************************/
    func testIsSubset() {
        let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
        let attendees: Set = ["Alicia", "Bethany", "Diana"]
        print(attendees.isSubset(of: employees))
    }
    
    
    // MARK: 5. INTEGER
    /*********************************
     ********INTEGER OPERATIONS*****
     *********************************/
    func integerOperations() {
        // 1. Int to Binary
        let intValue = 5
        let binary = String(intValue, radix: 2)
        
        print("binary: \(binary)")
        
        // 2. XOR two numbers
        let num1 = 10
        let num2 = 2
        print(String(num1, radix: 2))
        print(String(num2, radix: 2))
        let xorNum = num1 ^ num2
        print(String(xorNum, radix: 2))
    }
}


