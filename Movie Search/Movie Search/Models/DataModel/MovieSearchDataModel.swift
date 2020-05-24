//
//  MovieSearchDataModel.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchDataModel: Codable {
    var title = String()
    var posterPath = String()
    var overview = String()
    var id = Int()
    var posterData: Data?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title", overview = "overview", posterPath = "poster_path", id = "id"
    }
    
    func getData(data: Data) -> [String: Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            if let dictionary = jsonObject as? [String: Any] { return dictionary }
        } catch { print("Error: \(error.localizedDescription)") }
        return nil
    }
    
    static func setData(from dataDictionary: [[String: Any]]) -> [MovieSearchDataModel]? {
        let decoder = JSONDecoder()
        var movieSearchData = [MovieSearchDataModel]()
        for movieData in dataDictionary {
            do {
                
                let data = try JSONSerialization.data(withJSONObject: movieData, options: .prettyPrinted)
                let decodedData = try decoder.decode(MovieSearchDataModel.self, from: data)
                movieSearchData.append(decodedData)
                
            } catch { print("Error: \(error.localizedDescription)") }
        }
        return movieSearchData
        
    }

}
