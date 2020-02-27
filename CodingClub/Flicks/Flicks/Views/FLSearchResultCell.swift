//
//  FLSearchResultCell.swift
//  Flicks
//
//  Created by Ajith Antony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit
import CLImageDownloader

class FLSearchResultCell: UITableViewCell {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: CLCachedImageView!
    
    func setupWithPhoto(photoDataModel: FLPhotoDataModel?) {
        guard let photo = photoDataModel else {
            return
        }
        resultTitleLabel.text = photo.title
        resultImageView.loadImage(from: photo.thumbnailUrl, placehoderImage: Constants.placeholderImage)
    }

}
