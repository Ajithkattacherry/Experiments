//
//  SliderImageCache.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/8/21.
//

import Foundation

protocol ImageCacheProtocol {
    func saveImageData(forKey identifier: String, data: ImageDetails)
    func retrieveImageData(forKey identifier: String) -> ImageDetails?
}

extension ImageCacheProtocol {
    func saveImageData(forKey identifier: String, data: ImageDetails) {
        SliderImageCache.cache.setObject(data, forKey: identifier as NSString)
    }
    
    func retrieveImageData(forKey identifier: String) -> ImageDetails? {
        SliderImageCache.cache.object(forKey: identifier as NSString)
    }
}

class SliderImageCache: ImageCacheProtocol {
    static var cache = NSCache<NSString, ImageDetails>()
}
