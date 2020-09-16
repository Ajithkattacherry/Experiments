//
//  NetworkManager.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidURL
    case InvalidData
    case message(failureReason: String?)
}

class NetworkManager {
    static let session = URLSession.shared
    
    // GET REQUEST
    static func getList(onComplete: @escaping (Swift.Result<DataModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://demo0736356.mockable.io/getItems") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return onComplete(.failure(error))
            }
            guard let data = data else {
                return onComplete(.failure(NetworkManagerError.message(failureReason: "No data found")))
            }
            do {
                onComplete(.success(try DataModel.setData(data)))
            } catch (let error) {
                onComplete(.failure(error))
                return
            }
        }
        task.resume()
    }
    
    // POST REQUEST
    static func executeRequest(with url: URL, model: User, completion:  @escaping (Swift.Result<DataModel, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let jsonData = try? JSONEncoder().encode(model)
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { (data, response, error) in
            // Handle the response
        }
        task.resume()
    }
}
