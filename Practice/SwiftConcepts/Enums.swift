//
//  ProtocolType.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// Row Types and Init with Row types
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let char = ASCIIControlCharacter.init(rawValue: "\r") // output -> carriageReturn

// Associated Values
enum Direction {
    case north(_ count: Int)
    case south(_ count: String)
    case east(_ count:Int)
    case west(_ count:Int)
    
    init?(value: Int) {
        switch value {
        case 1:
            self = .north(value)
        case 2:
            self = .south("\(value)")
        case 3:
            self = .east(value)
        case 4:
            self = .west(value)
        default: return nil
        }
    }
    
}


