//
//  ViewController.swift
//  Couchbase_test
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myData: [String: Any] = ["Name": "Ajith",
                                 "ID": "DFS123",
                                 "Code": 3626.36]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        saveMyDocument()
        getMyDocument()
        search()
    }

    func saveMyDocument() {
        CouchbaseStack.shared.createDocument(with: "test_id_7218", properties: myData)
    }
    
    func getMyDocument() {
        guard let document = CouchbaseStack.shared.openDocument(with: "test_id_7218") else { return }
        print(document.id)
        if let name = document.string(forKey: "Name") {
            print(name)
        }
    }
    
    func search() {
        CouchbaseStack.shared.getResult()
    }
}

