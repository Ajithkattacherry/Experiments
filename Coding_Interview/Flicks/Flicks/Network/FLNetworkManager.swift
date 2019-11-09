//
//  FLNetworkManager.swift
//  Flicks
//
//  Created by Ajith Anthony on 11/9/19.
//  Copyright © 2019 Ajith Antony. All rights reserved.
//

import UIKit

class FLNetworkManager {
    typealias FlickrResponse = (NSError?, FLPhotoListDataModel?) -> Void

    class func fetchPhotosForSearchText(searchText: String, page: Int, onCompletion: @escaping FlickrResponse) -> Void {
        let escapedSearchText: String = searchText.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        let urlString: String = Service.host + Service.module + "\(Service.flickrKey)" + Service.text + "\(escapedSearchText)" + Service.format + "\(page)"
        guard let url = URL(string: urlString) else { return }
        let searchTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            // Error fetching photos
            if error != nil {
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    // Error code 100 - Invalid API key
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                guard let data = data else { return }
                let flPhotos = try FLPhotos.setData(data)
                onCompletion(nil, flPhotos?.photoListDataModel)
                
            } catch let error as NSError {
                // Error parsing JSON
                onCompletion(error, nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
}
