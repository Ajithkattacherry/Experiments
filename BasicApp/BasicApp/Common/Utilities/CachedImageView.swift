//
//  CachedImageView.swift
//  Demo4
//
//  Created by Ajith Anthony on 9/14/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class CustomImage: UIImage {
    var createdTime: Date?
}

class CachedImageView: UIImageView {
    private var cache = NSCache<NSString, CustomImage>()
    private var localImage: UIImage?
    
    func loadImage(from url: String, placeholder: String) {
        if let image = cache.object(forKey: url as NSString), image.createdTime ?? Date() < Date()  {
            return self.image = image
        }
        
        image = UIImage(named: placeholder)
        guard let actualURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: actualURL) { (data, response, error) in
            guard error == nil,
                let data = data,
                let customImage = CustomImage(data: data) else {
                return
            }
            customImage.createdTime = Date()
            self.cache.setObject(customImage, forKey: url as NSString)
            DispatchQueue.main.async {
                self.image = customImage
            }
        }.resume()
    }
}
