//
//  MovieSearchNetworkManager.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import Foundation


enum SessionError: String, Error {
    case NoData = "Missing data"
    case ConversionFailed = "Conversion from JSON failed"
}

class MovieSearchSessionManager {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    func movieSerchSessionCall(searchText: String, completionHandler: @escaping ([MovieSearchDataModel]?) -> Void) {
        guard let url = URL(string: String(format: Constants.searchAPI, searchText)) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completionHandler(nil)
                return
            }
            
            guard let movieData =  MovieSearchDataModel().getData(data: data),
                let result = movieData[Constants.results] as? [[String: Any]] else {
                completionHandler(nil)
                return
            }
            var searchData = [MovieSearchDataModel]()
            if let movieSearchDataModels = MovieSearchDataModel.setData(from: result) {
                for movieSearchDataModel in movieSearchDataModels {
                    if let chachedMode = self.cache.object(forKey: movieSearchDataModel.id as AnyObject) as? MovieSearchDataModel {
                        searchData.append(chachedMode)
                    } else {
                        self.posterSessionCall(posterURL: Constants.posterURL + movieSearchDataModel.posterPath, completionHandler: { data in
                            movieSearchDataModel.posterData = data
                            searchData.append(movieSearchDataModel)
                            self.cache.setObject(movieSearchDataModel, forKey: movieSearchDataModel.id as AnyObject)
                            print("Result: \(searchData.count)")
                            completionHandler(searchData)
                        })
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func posterSessionCall(posterURL: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: posterURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        task.resume()
    }
}
