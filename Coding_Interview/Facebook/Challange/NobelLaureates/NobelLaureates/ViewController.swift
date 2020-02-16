//
//  ViewController.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import MapKit

class ViewController : UIViewController {
    private let locationManager = CLLocationManager()
    private var selectedPin: MKPlacemark?
    private var selectedAnnotation: MKPointAnnotation?
    private var resultSearchController:UISearchController!
    private var nobelPrizeLaureatesListModel: NobelPrizeLaureatesListModel?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLocationManager()
        setUpLocationResultView()
        loadNobelPrizeData()
    }
    
    // MARK: Local methods
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func setUpLocationResultView() {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
    }
    
    func addAnnotations(from nobelPrizeLaureatesListModel: NobelPrizeLaureatesListModel?) {
        guard let nobelPrizeLaureatesList = nobelPrizeLaureatesListModel else {
            return
        }
        
        for nobelPrizeLaureatesData in nobelPrizeLaureatesList.nobelPrizeLaureates {
            let annotation = MKPointAnnotation()
            let location = CLLocationCoordinate2D(latitude: nobelPrizeLaureatesData.location.lat, longitude: nobelPrizeLaureatesData.location.lng)
            annotation.coordinate = location
            annotation.title = nobelPrizeLaureatesData.name
            annotation.subtitle = "\(nobelPrizeLaureatesData.borncity) \(nobelPrizeLaureatesData.country)"
            mapView.addAnnotation(annotation)
        }
    }
    
    func loadNobelPrizeData() {
        if let fileURL = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: fileURL, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                nobelPrizeLaureatesListModel = try decoder.decode(NobelPrizeLaureatesListModel.self, from: data)
                addAnnotations(from: nobelPrizeLaureatesListModel)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func showSearchBar(_ sender: AnyObject) {
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.delegate = self as? UISearchBarDelegate
        resultSearchController.searchBar.placeholder = "Search for Nobel Laureates"
        present(resultSearchController, animated: true, completion: nil)
    }
}

// MARK: Location Manager Delegate
extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }   
}

// MARK: Map SearchResult Handler Delegate
extension ViewController: MapSearchResultHandlerDelegate {
    func dropPinZoomIn(placemark: MKPlacemark){
        // clear existing pins
        if let annotation = selectedAnnotation {
            mapView.removeAnnotation(annotation)
        }
        // cache the pin
        selectedPin = placemark
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        selectedAnnotation = annotation
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
