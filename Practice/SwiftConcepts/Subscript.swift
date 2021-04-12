//
//  Subscript.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

struct CollectionItem<T: Sequence> where T.Element: Equatable {
    var list: T
    
    subscript(countOf value: T.Element) -> Int {
        return list.filter { $0 == value }.count
    }
}

/// TEST
//let list = "This is a list of items"
//let cust = CollectionItem(list: list)
//print(cust[countOf: "i"]) -> 4
