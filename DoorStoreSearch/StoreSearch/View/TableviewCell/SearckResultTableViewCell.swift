//
//  SearckResultTableViewCell.swift
//  StoreSearch
//
//  Created by Ajith Anthony on 9/21/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class SearckResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultCell"
    @IBOutlet weak var lblName: UILabel!
    //@IBOutlet weak var storeimage: CustomImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(from list: StoreListViewModel) {
        lblName.text = list.name
        //storeimage.lo
    }

}
