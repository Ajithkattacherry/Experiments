//
//  ViewController.swift
//  Test
//
//  Created by Ajith Anthony on 3/30/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func test() -> Bool {
        var s = "A man, a plan, a canal: Panama"
        s = s.filter { $0.isLetter || $0.isNumber }
        let charArray = Array(s.lowercased())
        print(charArray)
        var i = 0, count = charArray.count - 1
        while i < count / 2 {
            if charArray[i] != charArray[count - i] {
                return false
            }
            i += 1
        }
        return true
    }
}
