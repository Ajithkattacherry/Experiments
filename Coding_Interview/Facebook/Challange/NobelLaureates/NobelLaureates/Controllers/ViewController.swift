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
    private var selectedAnnotation: MKPointAnnotation?
    private var selectedLocation: CLLocation?
    private var selectedYear: Int = 2020
    private var resultSearchController: UISearchController!
    private var nobelPrizeLaureatesListModel: NobelPrizeLaureatesListModel?
    private let yearPickerData = Array(1900...2020)
    
    lazy private var yearPickerView: UIPickerView = {
        let yearPickerView = UIPickerView(frame: CGRect(x: 0, y: view.frame.height - 200, width: view.frame.width, height: 200))
        yearPickerView.backgroundColor = .white
        yearPickerView.dataSource = self
        yearPickerView.delegate = self
        yearPickerView.selectRow(yearPickerData.count - 1, inComponent: 0, animated: false)
        yearPickerView.isHidden = true
        view.addSubview(yearPickerView)
        return yearPickerView
    }()
    
    private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        setUpLocationResultView()
        loadNobelPrizeData()
    }
    
    // MARK: Local methods
    private func setUpLocationResultView() {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: Constants.locationSearchTable) as! LocationSearchTableViewController
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: sender.date)
        selectedYear = calanderDate.year ?? 2020
    }
    
    /// Loading Nobel Prize Laureates from Json
    func loadNobelPrizeData() {
        if let fileURL = Bundle.main.url(forResource: Constants.nobelPrizeLaureates, withExtension: Constants.fileType) {
            do {
                let data = try Data.init(contentsOf: fileURL, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                nobelPrizeLaureatesListModel = try decoder.decode(NobelPrizeLaureatesListModel.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Calculate the cost for displaying Nobel Prize Laureates each based on new search
    ///
    /// This involves the cost calculation and annotation of result location
    /// - parameter key: nobelPrizeLaureatesListModel
    func renderAnnotations() {
        guard var nobelPrizeLaureatesList = nobelPrizeLaureatesListModel,
            let location = selectedLocation else {
                return
        }
        
        // Sorting the Nobel laureates in order of ascending cost.
        nobelPrizeLaureatesList.nobelPrizeLaureates.sort(by: {
            $0.distance(to: location, year: selectedYear) < $1.distance(to: location, year: selectedYear)
        })
        
        // Displaying first 20 Nobel laureates on Map
        for i in 0..<20 {
            let nobelPrizeLaureatesData = nobelPrizeLaureatesList.nobelPrizeLaureates[i]
            
            print("\n******* \(i + 1) ********\nCity: \(nobelPrizeLaureatesData.city)")
            print("Year: \(nobelPrizeLaureatesData.year)")
            print("Distance: \(nobelPrizeLaureatesData.distance(to: location, year: selectedYear).rounded()) km")
            
            let annotation = MKPointAnnotation()
            let location = CLLocationCoordinate2D(latitude: nobelPrizeLaureatesData.location.lat, longitude: nobelPrizeLaureatesData.location.lng)
            annotation.coordinate = location
            annotation.title = nobelPrizeLaureatesData.name
            annotation.subtitle = "\(nobelPrizeLaureatesData.borncity) \(nobelPrizeLaureatesData.country)"
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func showSearchBar(_ sender: AnyObject) {
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.delegate = self as? UISearchBarDelegate
        resultSearchController.searchBar.placeholder = Constants.searchBarPlaceHoderText
        present(resultSearchController, animated: true, completion: nil)
    }
    
    @IBAction func showNobelPrizeYears(_ sender: AnyObject) {
        yearPickerView.isHidden = false
    }
    
    @IBAction func showNobelPrizeList(_ sender: AnyObject) {
        
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
            if selectedLocation == nil {
                selectedLocation = CLLocation(latitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude)
                renderAnnotations()
            }
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }   
}

// MARK: Map SearchResult Handler Delegate
extension ViewController: MapSearchResultHandlerDelegate {
    func dropPinZoomIn(placemark: MKPlacemark){
        // Removing the old location annotation from Map
        if let annotation = selectedAnnotation {
            mapView.removeAnnotation(annotation)
        }
        
        // Add location result as map annotation
        let annotation = CustomPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = Constants.selectedLocation
        if let name = placemark.name,
            let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(name), \(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        
        // Storing the selected annotation so that we can remove it from map when search for a new location
        selectedAnnotation = annotation

        // Selcted location - This is used to calculate the cost of each Nobel prize laureates.
        selectedLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // Recalculate the cost and re-render the Annotations based on new location
        renderAnnotations()
    }
}

//MARK: — UIPickerView Delegate and Datasource Methods
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.yearPickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(yearPickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = yearPickerData[row]
        pickerView.isHidden = true
        
        // Recalculate the cost and re-render the Annotations based on selected year
        renderAnnotations()
    }
}

//MARK: — MKMapView Delegate Methods
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.mapPin) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Constants.mapPin)
        annotationView.canShowCallout = true
        annotationView.displayPriority = .required
        
        if annotation is CustomPointAnnotation {
            annotationView.image =  UIImage(imageLiteralResourceName: Constants.selectedMapPin)
            return annotationView
        } else if annotation is MKPointAnnotation {
            annotationView.image =  UIImage(imageLiteralResourceName: Constants.mapPin)
            return annotationView
        } else {
            return nil
        }
    }
}
