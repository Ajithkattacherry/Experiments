//
//  NobelListTableViewController.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/16/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import MapKit

class NobelListTableViewController: UITableViewController {
    var nobelPrizeLaureates = [NobelPrizeLaureatesModel]()
    var selectedLocation: CLLocation?
    var selectedYear: Int?
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.estimatedRowHeight = 194
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nobelPrizeLaureates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell") as? NobelListTableViewCell {
            var distance = 0
            if let location = selectedLocation, let year = selectedYear {
                distance = Int(nobelPrizeLaureates[indexPath.row].distance(to: location, year: year).rounded())
            }
            cell.set(firstName: nobelPrizeLaureates[indexPath.row].firstname,
                     category: nobelPrizeLaureates[indexPath.row].category,
                     year: nobelPrizeLaureates[indexPath.row].year,
                     universityName: nobelPrizeLaureates[indexPath.row].name,
                     location: nobelPrizeLaureates[indexPath.row].city + ", " + nobelPrizeLaureates[indexPath.row].country,
                     distance: String(distance))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}
