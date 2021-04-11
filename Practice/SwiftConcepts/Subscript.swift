//
//  Subscript.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

struct CustValue {
    subscript(_ value: Int) -> Int {
        return value * value
    }
}

let val = CustValue()
print(val[2])

