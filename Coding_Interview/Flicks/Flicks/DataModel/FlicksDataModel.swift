//
//  FlicksDataModel.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

struct FlicksDataModel {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var photos: [FlickerPhotos]
}

struct FlickerPhotos {
    var id: String
    var owner: Int
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: String
    var isfriend: String
    var isfamily: String
    
    var url: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}
