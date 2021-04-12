//
//  Generics.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// 1. Generic Function with type constaints and Associated type where clause
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

// 2. Generic Type
enum StackError: LocalizedError {
    case emptyStack
}

struct Stack<T> {
    private var items = [T]()
    var createdDate: Date
    
    init(date: Date) {
        createdDate = date
    }
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() throws -> T {
        if items.isEmpty {
            throw StackError.emptyStack
        } else {
            return items.removeLast()
        }
    }
}

extension Stack where T: Comparable {
    static func == (lhs: Stack, rhs: Stack) -> Bool {
        lhs.items == rhs.items
    }
    
    static func > (lhs: Stack, rhs: Stack) -> Bool {
        lhs.createdDate > rhs.createdDate
    }
    
    static func < (lhs: Stack, rhs: Stack) -> Bool {
        lhs.createdDate < rhs.createdDate
    }
}

// 3. Associated Type use case
protocol WebService {
    associatedtype Model
    func getAll(url: URL, completion: @escaping (Result<Model, Error>) -> Void)
}

struct Movie {
    var title: String
}

struct User {
    var name: String
}

class MovieWebService: WebService {
    typealias Model = Movie
    
    func getAll(url: URL, completion: @escaping (Result<Movie, Error>) -> Void) {
        
    }
}

class UserWebService: WebService {
    typealias Model = User
    
    func getAll(url: URL, completion: @escaping (Result<User, Error>) -> Void) {
        
    }
}


