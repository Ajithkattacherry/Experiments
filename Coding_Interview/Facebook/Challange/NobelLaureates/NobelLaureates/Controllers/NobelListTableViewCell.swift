//
//  NobelListTableViewCell.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/16/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class NobelListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblUniversityName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(firstName: String,
             category: String,
             year: String,
             universityName: String,
             location: String,
             distance: String) {
        lblFirstName.text = Constants.nameDescription + firstName
        lblCategory.text = Constants.categoryDescription + category
        lblYear.text = Constants.nobelYearDescription + year
        lblUniversityName.text = Constants.universityNameDescription + universityName
        lblLocation.text = Constants.locationDescription + location
        lblDistance.text = Constants.distanceDescription + distance + Constants.km
    }
}
