//
//  NetworkManager.swift
//  StoreSearch
//
//  Created by Ajith Anthony on 9/21/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidURL
    case invalidData
    case otherError(error: Error)
}

protocol NetworkManagerProtocl {
    func getStoreList(from url: String, completion: @escaping (Result<StoreListDataModel, NetworkManagerError>) -> Void)
}

class NetworkManager: NetworkManagerProtocl {
    
    func getStoreList(from url: String, completion: @escaping (Result<StoreListDataModel, NetworkManagerError>) -> Void) {
        
        guard let url = URL(string: url) else {
            return completion(.failure(.invalidURL))
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(.failure(.otherError(error: error as! Error)))
            }
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let model  = try JSONDecoder().decode(StoreListDataModel.self, from: data)
                print(model.results)
                completion(.success(model))
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
