//
//  ViewController.swift
//  NetworkSession
//
//  Created by Ajith Anthony on 4/25/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getJSONData() {
        guard let url = URL(string: "https://demo0736356.mockable.io/getCollections") else { return }
        session.dataTask(with: url) { (data, response, error) in
            if let _response = response {
                print(_response)
            }
            if let _data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: _data, options: [])
                    print(json)
                } catch let error {
                    print(error)
                }
            }
            if let _error = error {
                print(_error)
            }
        }.resume()
    }
    
    @IBAction func postJSONData() {
        
    }
    
    @IBAction func downloadData() {
        
    }
}

