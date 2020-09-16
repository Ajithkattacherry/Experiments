//
//  PostDataModel.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

struct User: Encodable {
    let name: String
    let surname: String
    let age: Int
    
    static func getData(from model: User) throws -> Data? {
        return try JSONEncoder().encode(model)
    }
}
