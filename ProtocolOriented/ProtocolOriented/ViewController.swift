//
//  ViewController.swift
//  ProtocolOriented
//
//  Created by Ajith Anthony on 5/26/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Protocols {
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        name = "Ajith"
        showName()
    }
    
    func showName() {
        (self as Protocols).showName()
        print("Antony")
    }
}

