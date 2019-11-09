//
//  FLCachedImageView.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

// UIImageView to load and cache images.
class FLCachedImageView: UIImageView {
    public static let imageCache = NSCache<NSString, FLDiscardableImageCacheItem>()
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */
    
    func loadImage(urlString: String, placehoderImage: String? = nil, completion: (() -> ())? = nil) {
        image = nil
        
        self.urlStringForChecking = urlString
        let urlKey = urlString as NSString
        
        if let image = placehoderImage {
            emptyImage = UIImage(named: image)
        }
        
        if let cachedItem = FLCachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        image = emptyImage
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data,
                    let image = UIImage(data: data) else {
                    return
                }
                
                let cacheItem = FLDiscardableImageCacheItem(image: image)
                FLCachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                
                if urlString == self?.urlStringForChecking {
                    self?.image = image
                    completion?()
                }
            }
        }).resume()
    }
}
