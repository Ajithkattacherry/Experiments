//
//  FLPhotoListDataModel.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

struct FLPhotos: Decodable {
    var photoListDataModel: FLPhotoListDataModel
    
    enum CodingKeys: String, CodingKey {
        case photoListDataModel = "photos"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoListDataModel = try container.decode(FLPhotoListDataModel.self, forKey: .photoListDataModel)
    }
    
    static func setData(_ data: Data) throws -> FLPhotos {
        return try JSONDecoder().decode(FLPhotos.self, from: data)
    }
}


struct FLPhotoListDataModel: Decodable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: String
    var photos: [FLPhotoDataModel]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
        case page, pages, perpage, total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perpage = try container.decode(Int.self, forKey: .perpage)
        total = try container.decode(String.self, forKey: .total)
        photos = try container.decode([FLPhotoDataModel].self, forKey: .photos)
    }
}

struct FLPhotoDataModel: Decodable {
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
