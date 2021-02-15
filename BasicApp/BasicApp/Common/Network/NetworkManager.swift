//
//  NetworkManager.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum LocalError: LocalizedError {
    case message(failureReason: String?)
}

class NetworkManager {
    static func getList(onComplete: @escaping (Swift.Result<DataModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://demo0736356.mockable.io/getItems") else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return onComplete(.failure(error))
            }
            guard let data = data else {
                return onComplete(.failure(LocalError.message(failureReason: "No data found")))
            }
            do {
                onComplete(.success(try DataModel.setData(data)))
            } catch (let error) {
                onComplete(.failure(LocalError.message(failureReason: error.localizedDescription)))
                return
            }
        }
        session.resume()
    }
}
