//
//  DataModel.swift
//  NetworkSession
//
//  Created by Ajith Anthony on 5/11/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    var id: String
    var orgId: String
    var category: String
    var value: String
    var displayName: String
    var description: String
    
    func getDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        guard let encodedData = try? encoder.encode(self) else { return [:]}
        do {
            let dictionary = try JSONSerialization.jsonObject(with: encodedData, options: .mutableContainers)
            return dictionary as? [String : Any]
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func setData(from dictionary: [String: Any]) -> DataModel? {
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return try decoder.decode(DataModel.self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
}
