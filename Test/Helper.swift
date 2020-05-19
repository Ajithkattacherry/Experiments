//
//  Helper.swift
//  Test
//
//  Created by Ajith Anthony on 5/18/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation
import UIKit


/*********************************
 ********STRING OPERATIONS********
 *********************************/
class Helper {
    let stringArray = ["45 Apple",
                        "32 Pineapple",
                        "21 Orange",
                        "43 Banana",
                        "23 Cherry",
                        "21 Kivi",
                        "74 Coconut"]
     var dicyionary = [String: String]()
    
    func stringOperations() {
        //1. String to Char array
        let sample = "Sample"
        let charArray = Array(sample)
        print(charArray)

        //2. Array of string to Dictionary
        for item in stringArray {
            let itemValues = item.components(separatedBy: " ")
            dicyionary[itemValues[0]] = itemValues[1]
        }
        print(dicyionary)

        //3. Search for string from a string
        let string = "This is a sample search test"
        print(string.contains("test"))

        //4. Components SEPERATED BY A CHAR
        let array = string.components(separatedBy: " ")
        print(array)

        //5. TRIMMING CHAR
        string.trimmingCharacters(in: .whitespaces)
        print(string)
    }

    /*********************************
    ********DICTIONARY OPERATIONS*****
    *********************************/
    func dictionaryOperations() {
        // All Keys
        let dicKeys = dicyionary.keys
        let dicValues = dicyionary.values
        print("Dic Keys: \(dicKeys)")
        print("Dic Keys: \(dicValues)")

        // Sort Dictionary by Key
        var sortedDictionary = dicyionary.sorted { $0.0 > $1.0 }
        print(sortedDictionary)

        // Sort Dictionary by Value
        sortedDictionary = dicyionary.sorted { $0.1 > $1.1 }
        print(sortedDictionary)

        // Key and Values from dictionary
        var keys = [String]()
        var values = [String]()
        for (key, value) in sortedDictionary {
            keys.append(key)
            values.append(value)
        }
        print(keys)
        print(values)

        // Filter keys based on condition
        let subKeys = dicyionary.keys.filter { Int($0) ?? 0 > 40 }
        print("keys: \(Array(subKeys))")
        print("\(Array(subKeys).contains("74"))")
    }

    /*********************************
    ********ARRAY OPERATIONS*****
    *********************************/


    /*********************************
    ********SET OPERATIONS*****
    *********************************/
}


