//
//  Codable.swift
//  Practice
//
//  Created by Ajith Anthony on 4/11/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// Encoding and Decoding
struct Person: Codable {
    var name: String
    var age: Int
    var record: Record
    
    struct Record: Codable {
        var location: String
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name = "Full Name"
        case age = "Age"
        case record = "Location"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(record.location, forKey: .record)
    }
}

extension Person {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        let location = try container.decode(String.self, forKey: .record)
        record = Record(location: location)
    }
}


//let person = Person(name: "Ajith", age: 33, record: Person.Record(location: "Fremont"))
//let data = try JSONEncoder().encode(person)
//let str = String(data: data, encoding: .utf8)
// Output -> Optional("{\"Full Name\":\"Ajith\",\"Age\":33,\"Location\":\"Fremont\"}")

//let record = try JSONDecoder().decode(Person.self, from: data)
// Output -> Person(name: "Ajith", age: 33, record: __lldb_expr_76.Person.Record(location: "Fremont"))
