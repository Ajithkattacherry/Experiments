//
//  SliderDataServiceManager.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import Foundation

class SliderDataServiceManager: NetworkManagerProtocol {    
    static func getManifestData(completion: @escaping (Result<ManifestData, NetworkError>) -> Void) {
        execute(urlString: Constants.baseURL + Constants.manifestPath, completion: completion)
    }
    
    static func getImageData(from identifier: String, completion: @escaping (Result<ImageDetails, NetworkError>) -> Void) {
        execute(urlString: Constants.baseURL + Constants.imageDetailpath + identifier, completion: completion)
    }
    
    static func getImage(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        loadImage(urlString: url, completion: completion)
    }
}
