//
//  NetworkManager.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case jsonDecodingError(error: Error)
    case invalidURL
    case InvalidData
    case InvalidURLResponse(errorCode: Int)
    case message(failureReason: String?)
}

class NetworkManager: NeteorkManagerProtocol {
    static let shared = NetworkManager()
    let session = URLSession(configuration: .default)
    
    // GET REQUEST
    func getList(onComplete: @escaping (Swift.Result<DataModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://demo0736356.mockable.io/getItems") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return onComplete(.failure(error))
            }

            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return onComplete(.failure(self.handleURLResponse(response)))
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
    func executePOSTRequest<T: Codable>(with url: String, model: T, completion:  @escaping (Swift.Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(NetworkManagerError.invalidURL)) }
        let request = setURLRequest(for: url, model: model)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(NetworkManagerError.InvalidData))
                return
            }
            do {
                // Aletrnative approach
                // let dataStr = String(data: data, encoding: .utf8)!
                // print(dataStr)
                // let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                // print(json["token"]!)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkManagerError.jsonDecodingError(error: error)))
            }
        }
        task.resume()
    }
}
