//
//  OpaqueType.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// 1. Example
protocol Product {
    associatedtype T
    var description: String { get }
    var productCode: T { get }
}

struct Laptop: Product {
    typealias T = String
    
    var description: String { "Laptop" }
    var productCode: String
}

struct Keyboard: Product {
    typealias T = Int
    
    var description: String { "Laptop" }
    var productCode: Int
}

struct ProductFactory {
    
    // some keyword tell the compiler that the Product return type is concrete. ie, of type Keyboard or Laptop
    private func makeKeyboard() -> some Product {
        Keyboard(productCode: 3123214)
    }
    
    private func makeLaptop() -> some Product {
        Laptop(productCode: "3123214")
    }
}

// 2. Example

struct Opaque {
    func getCustomList<T: Numeric>(_ array1: [T]) -> LazyMapSequence<Array<T>, T> {
        return array1.lazy.map { $0 * $0 }
    }
    
    // struct LazyMapSequence<Base, Element> where Base : Sequence
    // Since LazyMapSequence is confirmed to Sequence we can use opaque type there. It help to abstract the return type of getCustomList.
    func getCustomList<T: Numeric>(_ array2: [T]) -> some Sequence {
        return array2.lazy.map { $0 * $0 }
    }
}

