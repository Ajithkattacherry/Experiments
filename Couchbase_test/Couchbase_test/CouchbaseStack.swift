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
    case stateOpen
    case stateClose
    case id
    case code
    
    func getExpression() -> ExpressionProtocol? {
        switch self {
        case .stateOpen:
            return Expression.property("state").equalTo(Expression.string("open"))
        case .stateClose:
            return Expression.property("state").equalTo(Expression.string("close"))
        case .id:
            return Expression.property("id").equalTo(Expression.int(5005))
        case .code:
            return Expression.property("ppu").equalTo(Expression.double(0.55))
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
        
        database.addChangeListener { (change) in
            print(change.database)
            print(change.documentIDs)
        }
    }
    
    // Create a new document (i.e. a record) in the database.
    func createDocument(with id: String, properties: [String: Any]) {
        let mutableDoc = MutableDocument(id: id)
        mutableDoc.setData(properties)
        
        // Save it to the database.
        do {
            try database.saveDocument(mutableDoc)
        } catch {
            fatalError("Error saving document")
        }
        
        // Create index
        do {
            let index = IndexBuilder.fullTextIndex(items: FullTextIndexItem.property("name")).ignoreAccents(false)
            try database.createIndex(index, withName: "AjithTest")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func openDocument(with id: String) -> Document? {
        guard let document = database.document(withID: id) else { return nil }
        return document.toMutable()
    }
    
    // Create a query to fetch documents of type SDK.
    @discardableResult func getResult(expression: ExpressionProtocol? = nil) -> [DocumentDataModel] {
        var documentModel = [DocumentDataModel]()
        let query = QueryBuilder
            .select(
                SelectResult.expression(Meta.id),
                SelectResult.all()
            )
            .from(DataSource.database(database))
            .where(expression ?? Expression.all())
        
        // Adds a query change listener.
        // Changes will be posted on the main queue.
        let token = query.addChangeListener { (change) in
            for result in change.results! {
                print(result.keys)
            }
        }
        
        do {
            let enumeratorResult = try query.execute()
            print("Result count: \(enumeratorResult.allResults().count)")
            for result in try query.execute() {
                print("document id :: \(result.string(forKey: "id")!)")
                guard let document = openDocument(with: result.string(forKey: "id")!) else { return [] }
                let model = DocumentDataModel(state: document.state,
                                              id: document.id,
                                              name: document.name,
                                              batterType: document.batterType,
                                              toppingType: document.toppingType)
                documentModel.append(model)
            }
        } catch {
            print(error)
        }
        return documentModel
    }
    
    func testFullTextSearch() {
        // Insert documents
        let tasks = ["buy groceries", "play chess", "book travels", "buy museum tickets"]
        for task in tasks {
            let doc = MutableDocument()
            doc.setString("task", forKey: "type")
            doc.setString(task, forKey: "list")
            try? database.saveDocument(doc)
        }
        
//        let tasks = ["list": ["buy groceries", "play chess", "book travels", "buy museum tickets"]]
//        let doc = MutableDocument()
//        doc.setData(tasks)
//        try? database.saveDocument(doc)
        
        // Create index
        do {
            let index = IndexBuilder.fullTextIndex(items: FullTextIndexItem.property("list")).ignoreAccents(false)
            try database.createIndex(index, withName: "nameFTSIndex")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchDocuments(for text: String) -> [String] {
        var resultArray = [String]()
        let whereClause = FullTextExpression.index("nameFTSIndex").match(text)
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(whereClause)
        
        do {
            let results = try query.execute()
            guard !results.allResults().isEmpty else {
                print("No Items found")
                return []
            }
            for result in try query.execute() {
                print("document Property \(result.toDictionary())")
                let result = (result.toDictionary().keys.first ?? "") + ": " + (result.toDictionary().values.first as? String ?? "")
                resultArray.append(result)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return resultArray
    }
    
    func fetchDocumentsFromDocument(for text: String) -> [String] {
        var resultArray = [String]()
        let whereClause = FullTextExpression.index("AjithTest").match(text)
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(whereClause)
        
        do {
            let results = try query.execute()
            guard !results.allResults().isEmpty else {
                print("No Items found")
                return []
            }
            for result in try query.execute() {
                print("document Property \(result.toDictionary())")
                let result = (result.toDictionary().keys.first ?? "") + ": " + (result.toDictionary().values.first as? String ?? "")
                resultArray.append(result)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return resultArray
    }
}
