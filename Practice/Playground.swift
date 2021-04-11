//
//  Playground.swift
//  Practice
//
//  Created by Ajith Anthony on 12/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

func test() {
    let array = ["un","iq","ue"]
    print(hasDuplicate(in: array))
}

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

enum MyOptionalError: Error {
    case itemNotFound
}

