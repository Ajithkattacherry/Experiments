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
        print(merge([[1,3],[2,6],[8,10],[15,18]]))
        Helper().testArrayJoin()
    }
}
