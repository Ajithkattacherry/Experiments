//
//  ViewController.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class ViewController : UIViewController {
    private let locationManager = CLLocationManager()
    private var selectedPin: MKPlacemark?
    private var selectedAnnotation: MKPointAnnotation?
    private var selectedLocation: CLLocation?
    private var selectedYear: Int = 2020
    private var resultSearchController:UISearchController!
    private var nobelPrizeLaureatesListModel: NobelPrizeLaureatesListModel?
    private var pickerView: UIPickerView!
    private let titles = Array(1900...2020)
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLocationManager()
        setUpLocationResultView()
        setUpPickerView()
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
    
    private func setUpPickerView() {
        pickerView = UIPickerView(frame: CGRect(x: 0,
                                                y: self.view.frame.height - 200,
                                                width: self.view.frame.width,
                                                height: 200))
        self.pickerView.backgroundColor = .white
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(120, inComponent: 0, animated: false)
        self.view.addSubview(pickerView)
        pickerView.isHidden = true
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: sender.date)
        selectedYear = calanderDate.year ?? 2020
    }
    
    func addAnnotations(from nobelPrizeLaureatesListModel: NobelPrizeLaureatesListModel?) {
        guard var nobelPrizeLaureatesList = nobelPrizeLaureatesListModel,
            var location = selectedLocation else {
                return
        }
        if let annotation = selectedAnnotation {
            location = CLLocation(latitude: annotation.coordinate.latitude,
                                  longitude: annotation.coordinate.longitude)
            selectedLocation = location
        }
        nobelPrizeLaureatesList.nobelPrizeLaureates.sort(by: { $0.distance(to: location, year: selectedYear) < $1.distance(to: location, year: selectedYear) })
        for i in 0..<20 {
            let nobelPrizeLaureatesData = nobelPrizeLaureatesList.nobelPrizeLaureates[i]
            print(nobelPrizeLaureatesData.city)
            print(nobelPrizeLaureatesData.year)
            print(nobelPrizeLaureatesData.distance(to: location, year: selectedYear))
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
    
    @IBAction func showNobelPrizeYears(_ sender: AnyObject) {
        pickerView.isHidden = false
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
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0))
            if selectedAnnotation == nil {
                selectedLocation = CLLocation(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude)
                addAnnotations(from: nobelPrizeLaureatesListModel)
            }
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
        let annotation = CustomPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = "Selected Location"
        
        if let name = placemark.name,
            let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(name), \(city) \(state)"
        }
        selectedAnnotation = annotation
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        addAnnotations(from: nobelPrizeLaureatesListModel)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titles.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(titles[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = titles[row]
        addAnnotations(from: nobelPrizeLaureatesListModel)
        pickerView.isHidden = true
    }
}

//MARK: — MKMapView Delegate Methods
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.canShowCallout = true
        annotationView.displayPriority = .required
        
        if annotation is CustomPointAnnotation {
            annotationView.image =  UIImage(imageLiteralResourceName: "custom")
            return annotationView
        } else if annotation is MKPointAnnotation {
            annotationView.image =  UIImage(imageLiteralResourceName: identifier)
            return annotationView
        } else {
            return nil
        }
    }
}
