//
//  DocumentDataModel.swift
//  Couchbase
//
//  Created by Ajith Anthony on 5/5/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit
import CouchbaseLiteSwift

struct DocumentDataModel {
    let state: String
    let id: String
    let name: String
    let batterType: String
    let toppingType: String
}

extension Document {
    var state: String {
        let properties = toDictionary()
        guard let state = properties["state"] as? String else { return "" }
        return state
    }
    
    var docId: String {
        let properties = toDictionary()
        guard let data = properties["data"] as? [[String: Any]],
            let id = data.first?["id"] as? String
            else { return "" }
        return id
    }
    
    var name: String {
        let properties = toDictionary()
        guard let data = properties["data"] as? [[String: Any]],
            let name = data.first?["name"] as? String
            else { return "" }
        return name
    }
    
    var batterType: String {
        let properties = toDictionary()
        guard let data = properties["data"] as? [[String: Any]],
            let batters = data.first?["batters"] as? [String: Any],
            let batter = batters["batter"] as? [[String: Any]],
            let batterType = batter.first?["type"] as? String
            else { return "" }
        return batterType
    }
    
    var toppingType: String {
        let properties = toDictionary()
        guard let data = properties["data"] as? [[String: Any]],
            let topping = data.first?["topping"] as? [[String: Any]],
            let toppingType = topping.first?["type"] as? String
            else { return "" }
        return toppingType
    }
}
