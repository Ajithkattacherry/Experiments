//
//  Helper.swift
//  Couchbase
//
//  Created by Ajith Anthony on 5/3/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import Foundation

struct FileType {
    static let jsonType = "json"
    static let pdf = "txt"
    static let csv = "csv"
}

// Get form elements from json file
func getFormElements(from filename: String) -> [String: Any]? {
    guard let jsonString = getBundleFileContent(for: filename, extensionType: FileType.jsonType),
        let data = jsonString.data(using: .utf8)
        else { return nil }
    
    do {
        let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return jsonData as? [String: Any]
    } catch { return nil }
}

func getBundleFileContent(for filename: String, extensionType: String) -> String? {
    var stringContent: String?
    guard !filename.isEmpty,
        let file = Bundle.main.url(forResource: filename, withExtension: extensionType)
        else { return nil }
    do {
        stringContent = try String(contentsOf: file, encoding: String.Encoding.utf8)
    } catch {
        print(error.localizedDescription)
    }
    return stringContent
}
