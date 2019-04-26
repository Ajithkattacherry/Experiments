//
//  ViewController.swift
//  KVO
//
//  Created by Ajith Anthony on 4/25/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class User: NSObject {
    @objc dynamic var age = 10
}

class ViewController: UIViewController {
    
    @IBOutlet weak var lblNewValue: UILabel!
    @IBOutlet weak var txtNewValue: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @objc let user = User()
    var ageObservationToken: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ageObservationToken = observe(\ViewController.user.age, options: [.new]) { (self, value) in
            let text = value.newValue ?? 0
            self.lblNewValue.text = String(text)
        }
    }

    @IBAction func updateLabel(sender: UIButton) {
        guard let userInput = txtNewValue.text else { return }
        user.age = Int(userInput) ?? 0
    }

}

