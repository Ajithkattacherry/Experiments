//
//  NetworkManager.swift
//  BasicApp
//
//  Created by Ajith Anthony on 7/7/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

class NetworkManager {
    static func getList(onComplete: @escaping (Swift.Result<DataModel, NSError>) -> Void) {
        
        guard let url = URL(string: "https://demo0736356.mockable.io/contacts/userid/duplicates") else {
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return onComplete(.failure(NSError()))
            } else {
                guard let data = data else {
                    return
                }
                do {
                    onComplete(.success(try DataModel.setData(data)))
                } catch (let error) {
                    onComplete(.failure(error as NSError))
                    return
                }
            }
        }
        session.resume()
    }
}
