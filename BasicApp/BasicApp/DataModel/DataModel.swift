//
//  DataModel.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

struct DataModel: Decodable {
    var categoryItems: [ListDataModel]
    
    enum CodingKeys: String, CodingKey {
        case categoryItems = "items"
    }
    
    static func setData(_ data: Data) throws -> DataModel {
        return try JSONDecoder().decode(DataModel.self, from: data)
    }
}

struct Values: Decodable {
    var description: String = ""
    var imageName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case description = "details", imageName = "url"
    }
}

struct ListDataModel: Decodable {
    var title: String = ""
    var values: Values
}
