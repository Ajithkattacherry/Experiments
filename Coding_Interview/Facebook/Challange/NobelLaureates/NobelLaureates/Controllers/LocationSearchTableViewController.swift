//
//  LocationSearchTableViewController.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchResultHandlerDelegate: class {
    func dropPinZoomIn(placemark: MKPlacemark)
}

class LocationSearchTableViewController: UITableViewController {
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    weak var handleMapSearchDelegate: MapSearchResultHandlerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Methods
    func getAddress(from placemark:MKPlacemark) -> String {
        var addressString : String = ""
        if let subThoroughfare = placemark.subThoroughfare {
            addressString = subThoroughfare + " "
        }
        if let thoroughfare = placemark.thoroughfare {
            addressString = addressString + thoroughfare + ", "
        }
        if let postalCode = placemark.postalCode {
            addressString = addressString + postalCode + " "
        }
        if let locality = placemark.locality {
            addressString = addressString + locality + ", "
        }
        if let administrativeArea = placemark.administrativeArea {
            addressString = addressString + administrativeArea
        }
        if let country = placemark.country {
            addressString = addressString + ", " + country
        }
        return addressString
    }
}

// MARK: TableView delegates and datasource
extension LocationSearchTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)!
        let placemark = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = placemark.name
        cell.detailTextLabel?.text = getAddress(from: placemark)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UISearchResultsUpdating delegate
extension LocationSearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
