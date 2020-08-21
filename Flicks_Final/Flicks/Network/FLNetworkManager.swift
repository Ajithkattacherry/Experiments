//
//  FLNetworkManager.swift
//  Flicks
//
//  Created by Ajith Antony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

enum Result<NSError, FLPhotoListDataModel> {
    case success(FLPhotoListDataModel)
    case failure(NSError)
}

class FLNetworkManager {
    class func fetchPhotos(for searchText: String, on page: Int, onCompletion: @escaping (Result<NSError, FLPhotoListDataModel>) -> Void) {
        let escapedSearchText: String = searchText.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        let urlString: String = Service.host + Service.module + "\(Service.flickrKey)" + Service.text + "\(escapedSearchText)" + Service.format + "\(page)"
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(NSError(domain: "com.flickr.api", code: Errors.invalidURLErrorCode, userInfo: nil)))
            return
        }
        let searchTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            // Error fetching photos
            if let error = error {
                onCompletion(.failure(error as NSError))
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else {
                    onCompletion(.failure(NSError(domain: "com.flicks.api", code: Errors.operationFailedErrorCode, userInfo: nil)))
                    return
                }
                
                if let statusCode = results["code"] as? Int {
                    // Error code 100 - Invalid API key
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "com.flicks.api", code: statusCode, userInfo: nil)
                        onCompletion(.failure(invalidAccessError))
                        return
                    }
                }
                guard let data = data else {
                    onCompletion(.failure(NSError(domain: "com.flicks.api", code: Errors.operationFailedErrorCode, userInfo: nil)))
                    return
                }
                let flPhotos = try FLPhotos.setData(data)
                onCompletion(.success(flPhotos.photoListDataModel))
                
            } catch let error as NSError {
                // Error parsing JSON
                onCompletion(.failure(error))
                return
            }
            
        })
        searchTask.resume()
    }
    
}
