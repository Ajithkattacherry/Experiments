//
//  SearchResultCell.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    func setupWithPhoto(flickerPhotos: FlickerPhotos?) {
        guard let photos = flickerPhotos else {
            return
        }
        resultTitleLabel.text = photos.title
        //resultImageView.sd_setImage(with: photos.url as? URL)
    }

}
