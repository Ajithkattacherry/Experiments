//
//  ViewController.swift
//  Couchbase_test
//
//  Created by Ajith Anthony on 5/2/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtSearchField.delegate = self
        saveMyDocument()
        getMyDocument()
        search()
    }

    private func saveMyDocument() {
        guard let document = getFormElements(from: "document") else { return }
        CouchbaseStack.shared.createDocument(with: "test_id_7218", properties: document)
        CouchbaseStack.shared.testFullTextSearch()
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
    
    @IBAction func didTapOnSearch(_ sender: Any) {
        view.endEditing(true)
        let result = CouchbaseStack.shared.fetchDocuments(for: lblResult.text ?? "")
        //let result = CouchbaseStack.shared.fetchDocumentsFromDocument(for: lblResult.text ?? "")
        lblResult.text = result.joined(separator: "\n")
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lblResult.text = textField.text
        view.setNeedsDisplay()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        lblResult.text = textField.text
        view.setNeedsDisplay()
    }
    
}

