//
//  FLPhotosDetailViewController.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FLPhotosDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoDataModel: FLPhotoDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard photoDataModel != nil else { return }
        //photoImageView.sd_setImage(with: photoListDataModel!.photoUrl as? URL)
    }

}
