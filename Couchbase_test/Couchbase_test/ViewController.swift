//
//  ViewController.swift
//  Couchbase_test
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        saveMyDocument()
        getMyDocument()
        search()
    }

    private func saveMyDocument() {
        guard let document = getFormElements(from: "document") else { return }
        CouchbaseStack.shared.createDocument(with: "test_id_7218", properties: document)
    }
    
    private func getMyDocument() {
        guard let document = CouchbaseStack.shared.openDocument(with: "test_id_7218") else { return }
        let documentDic = document.toDictionary()
        print(document.id)
        print(documentDic)
    }
    
    private func search() {
        // Search for all docs
        CouchbaseStack.shared.getResult()
        
        // Search for open state docs
        CouchbaseStack.shared.getResult(expression: QueryType.stateOpen.getExpression())
        
        // Search for close state docs
        CouchbaseStack.shared.getResult(expression: QueryType.stateClose.getExpression())
    }
}

