//
//  CouchbaseStack.swift
//  Couchbase
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit
import CouchbaseLiteSwift

enum QueryType {
    case name
    case id
    case code
    
    func getExpression() -> ExpressionProtocol? {
        switch self {
        case .name:
            return Expression.property("Name").equalTo(Expression.string("Ajith"))
        case .id:
            return Expression.property("ID").equalTo(Expression.string("DFS123"))
        case .code:
            return Expression.property("Code").equalTo(Expression.double(3626.36))
        }
    }
}

class CouchbaseStack: NSObject {
    static let shared = CouchbaseStack()
    private let database: Database
    
    override init() {
        do {
            database = try Database(name: "CouchBaseDB")
        } catch {
            fatalError("Error opening database")
        }
    }
    
    // Create a new document (i.e. a record) in the database.
    func createDocument(with id: String, properties: [String: Any]) {
        let mutableDoc = MutableDocument(id: id)
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
    
    // Create a query to fetch documents of type SDK.
    func getResult() {
        let query = QueryBuilder
            .select(
                SelectResult.expression(Meta.id),
                SelectResult.property("Name"),
                SelectResult.property("ID")
            )
            .from(DataSource.database(database))
        
        do {
            for result in try query.execute() {
                if let name =  result.string(forKey: "Name") {
                    print("Name :: \(name)")
                }
                if let id = result.string(forKey: "ID") {
                    print("ID :: \(id)")
                }
            }
        } catch {
            print(error)
        }
    }
}
