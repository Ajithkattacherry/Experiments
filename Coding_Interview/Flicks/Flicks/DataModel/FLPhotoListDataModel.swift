//
//  FLPhotoListDataModel.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

struct FLPhotoListDataModel {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var photos: [FLPhotoDataModel]
}

struct FLPhotoDataModel {
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
    
    var thumbnailUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
    
    var url: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg"
    }
}
