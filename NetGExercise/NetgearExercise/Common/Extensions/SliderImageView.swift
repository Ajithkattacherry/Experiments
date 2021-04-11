//
//  SliderImageView.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import Foundation
import UIKit

protocol SliderImageDelegate: AnyObject {
    func imageLoadDidComplete()
}

class CustomImage: UIImage, Codable {
    var createdTime: Date?
}

class SliderImageView: UIImageView, ImageCacheProtocol {
    weak var delegate: SliderImageDelegate?
    
    func loadImage(from identifier: String, placeholder: String) {
        if let imageDetails = retrieveImageData(forKey: identifier),
           imageDetails.slideImage?.createdTime ?? Date.yesterday > Date.yesterday  {
            self.image = imageDetails.slideImage
            return
        }
        
        image = UIImage(named: placeholder)
        DispatchQueue.global(qos: .userInitiated).async {
            SliderDataServiceManager.shared.getImageData(from: identifier) { (result) in
                switch result {
                case .success(let imageDetails):
                    guard let url = imageDetails.url else {
                        return
                    }
                    SliderDataServiceManager.shared.getImage(from: url) { (result) in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                let customImage = CustomImage(data: imageData)
                                customImage?.createdTime = Date()
                                imageDetails.slideImage = customImage
                                self.saveImageData(forKey: identifier, data: imageDetails) // NOTE: Im-memory caching is implemented now. It could be a persistant storage approach based on the requirement.
                                self.image = customImage
                                self.delegate?.imageLoadDidComplete()
                            }
                        case .failure( _):
                            self.image = UIImage(named: "noimage")
                        }
                    }
                case .failure( _):
                    self.image = UIImage(named: "noimage")
                }
            }
        }
    }
}
