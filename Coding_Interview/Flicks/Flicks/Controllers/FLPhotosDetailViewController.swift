//
//  FLPhotosDetailViewController.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FLPhotosDetailViewController: UIViewController {
    @IBOutlet weak var photoImageView: FLCachedImageView!
    var photoDataModel: FLPhotoDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photo = photoDataModel else { return }
        photoImageView.loadImage(from: photo.url, placehoderImage: Constants.placeholderImage)
    }

}
