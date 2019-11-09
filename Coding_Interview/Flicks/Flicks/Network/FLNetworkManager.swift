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
    
    class func fetchPhotosForSearchText(searchText: String, onCompletion: @escaping FlickrResponse) -> Void {
        let escapedSearchText: String = searchText.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        //let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&tags=\(escapedSearchText)&per_page=25&format=json&nojsoncallback=1"
        let urlString = "https://demo0736356.mockable.io/getPhotos"
        let url: URL = URL(string: urlString)!
        let searchTask = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("Error fetching photos: \(String(describing: error))")
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results["code"] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                let page = photosContainer["page"] as? Int ?? 0
                let pages = photosContainer["pages"] as? Int ?? 0
                let perpage = photosContainer["perpage"] as? Int ?? 0
                let total = photosContainer["total"] as? Int ?? 0
                
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }

                let flickrPhoto: [FLPhotoDataModel] = photosArray.map { photoDictionary in
                    let id = photoDictionary["id"] as? String ?? ""
                    let owner = photoDictionary["owner"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let title = photoDictionary["title"] as? String ?? ""
                    let ispublic = photoDictionary["ispublic"] as? String ?? ""
                    let isfriend = photoDictionary["isfriend"] as? String ?? ""
                    let isfamily = photoDictionary["isfamily"] as? String ?? ""
                    return FLPhotoDataModel(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title, ispublic: ispublic, isfriend: isfriend, isfamily: isfamily)
                }
                onCompletion(nil, FLPhotoListDataModel(page: page, pages: pages, perpage: perpage, total: total, photos: flickrPhoto))
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error, nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
}
