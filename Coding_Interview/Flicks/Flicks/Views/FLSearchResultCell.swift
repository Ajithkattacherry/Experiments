//
//  FLSearchResultCell.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FLSearchResultCell: UITableViewCell {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: FLCachedImageView!
    
    func setupWithPhoto(photoDataModel: FLPhotoDataModel?) {
        guard let photo = photoDataModel else {
            return
        }
        resultTitleLabel.text = photo.title
        resultImageView.loadImage(urlString: photo.thumbnailUrl)
    }

}
