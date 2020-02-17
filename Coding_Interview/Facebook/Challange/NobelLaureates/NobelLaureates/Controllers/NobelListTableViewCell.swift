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
        lblFirstName.text = "Name: " + firstName
        lblCategory.text = "Category: " + category
        lblYear.text = "Nobel Year: " + year
        lblUniversityName.text = "University Name: " + universityName
        lblLocation.text = "Location: " + location
        lblDistance.text = "Distance from selected Location: " + distance + "Km"
    }
}
