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
    let array = ["20191026", "20230423", "20200423", "20231123", "20190111"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let aray = removeComments(["/*Test program */", "int main()", "{ ", "  // variable declaration ", "int a, b, c;", "/* This is a test", "   multiline  ", "   comment for ", "   testing */", "a = b + c;", "}"])
        aray.map { print($0) }
    }
}
