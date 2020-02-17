//
//  NobelPrizeLaureatesViewModel.swift
//  NobelLaureates
//
//  Created by Ajith Anthony on 2/15/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation
import MapKit

struct NobelPrizeLaureatesListModel: Decodable {
    var nobelPrizeLaureates: [NobelPrizeLaureatesModel]
    
    static func setData(_ data: Data) throws -> NobelPrizeLaureatesListModel {
        return try JSONDecoder().decode(NobelPrizeLaureatesListModel.self, from: data)
    }
}

struct NobelPrizeLaureatesModel: Decodable {
    var id: Int
    var category: String
    var died: String
    var diedcity: String
    var borncity: String
    var born: String
    var surname: String
    var firstname: String
    var motivation: String
    var location: Location
    var city: String
    var borncountry: String
    var year: String
    var diedcountry: String
    var country: String
    var gender: String
    var name: String
    
    var eventLocation: CLLocation {
        return CLLocation(latitude: location.lat, longitude: location.lng)
    }
    
    func distance(to location: CLLocation, year selectedYear: Int) -> CLLocationDistance {
        let costOfYear = Double(abs(selectedYear - (Int(year) ?? 0)) * 10)
        let locationDistance = eventLocation.distance(from: location) / 100
        return locationDistance + costOfYear
    }
}

struct Location: Decodable {
    var lat: Double
    var lng: Double
}
