//
//  FlicksDetailViewController.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FlicksDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var flickerPhotos: FlickerPhotos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard flickerPhotos != nil else { return }
        //photoImageView.sd_setImage(with: flicksDataModel!.photoUrl as? URL)
    }

}
