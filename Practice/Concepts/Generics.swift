//
//  Generics.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

struct Collections {
   func hasDuplicate<T: Sequence>(in collection: T) -> Bool where T.Element: Hashable {
        var dic = [T.Element: Int]()
        for element in collection {
            if dic[element] != nil {
                return true
            }
            dic[element] = 0
        }
        return false
    }
}
