//
//  ImagePresentationDataModel.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import Foundation
import UIKit

struct ManifestData: Codable {
    var imageGroups: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case imageGroups = "manifest"
    }
}

class ImageDetails: Codable {
    var name: String?
    var url: String?
    var type: String?
    var width: Int?
    var height: Int?
    var slideImage: CustomImage?
}
