//
//  ViewController.swift
//  Test
//
//  Created by Ajith Anthony on 3/30/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import Foundation

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    func testMethod(completion: @escaping (String) -> Void) {
        print("testMethod")
        sleep(10)
        DispatchQueue.global().async {
            completion(self.name)
        }
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

class ViewController: UIViewController {
    
    var label = UILabel()
    var paragraph: HTMLElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = Array("ABC")
        var output = [String]()
        permutations(arr.count, &arr, output: &output)
        print(output)
    }
    
    func test() {
        paragraph = HTMLElement(name: "Ajit", text: "test")
        paragraph?.testMethod{ value in
            DispatchQueue.main.async {
                print(self.label.text!)
            }
            print("testMethod completed")
        }
        paragraph?.asHTML()
        paragraph = nil
    }
}
