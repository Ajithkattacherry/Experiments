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
    @IBOutlet weak var resultImageView: UIImageView!
    
    func setupWithPhoto(photoDataModel: FLPhotoDataModel?) {
        guard let photos = photoDataModel else {
            return
        }
        resultTitleLabel.text = photos.title
        //resultImageView.sd_setImage(with: photos.url as? URL)
    }

}
