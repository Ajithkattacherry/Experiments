//
//  StoreListDataModel.swift
//  StoreSearch
//
//  Created by Ajith Anthony on 9/21/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

struct StoreListDataModel: Codable {
    var results: [StoreList]
}

struct StoreList: Codable {
    var name: String
    var deliveryFee: Int
    var coverImgageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name, deliveryFee = "delivery_fee", coverImgageURL = "cover_img_url"
    }
}
