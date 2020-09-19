//
//  PostDataModel.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

struct User: Codable {
    let name: String?
    let surname: String?
    let age: Int?
    let token: String?
    
    static func getData(from model: User) throws -> Data? {
        return try JSONEncoder().encode(model)
    }
    
    static func getModel(from data: Data) throws -> User {
        return try JSONDecoder().decode(User.self, from: data)
    }
}
