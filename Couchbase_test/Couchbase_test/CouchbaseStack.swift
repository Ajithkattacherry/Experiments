//
//  CouchbaseStack.swift
//  Couchbase
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit
import CouchbaseLiteSwift

class CouchbaseStack: NSObject {
    
    static let shared = CouchbaseStack()
    
    fileprivate let database: Database
    
    override init() {
        do {
            database = try Database(name: "CouchBaseDB")
        } catch {
            fatalError("Error opening database")
        }
    }
    
    // Create a new document (i.e. a record) in the database.
    func createDocument(with properties: [String: Any]) {
        let mutableDoc = MutableDocument(id: "test_id_7218")
        for key in properties.keys {
            if let value = properties[key]  as? String {
                mutableDoc.setString(value, forKey: key)
            } else if let value = properties[key]  as? Double {
                mutableDoc.setDouble(value, forKey: key)
            }
        }
        
        // Save it to the database.
        do {
            try database.saveDocument(mutableDoc)
        } catch {
            fatalError("Error saving document")
        }
    }
    
    func openDocument(with id: String) -> Document? {
        guard let document = database.document(withID: id) else { return nil }
        return document.toMutable()
    }
}
