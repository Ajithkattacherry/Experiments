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
        //var arr = Array("ABC")
        //permutations(arr.count, &arr)
        print(numberBetweenTheDuplicates([2, 3, 4, 2, 3, 2]))
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
    
    func subdomainVisits(_ cpdomains: [String]) -> [String] {
        var hashMap = [String: Int]()
        for domains in cpdomains {
            let array = domains.split(separator: " ")
            let count = array.first ?? ""
            let domain = (array.last ?? "").split(separator: ".")
            var i = 0
            print(Int(count) ?? 0)
            print(domain[0..<domain.count])
            while i < domain.count {
                let subDomain = domain[i..<domain.count]
                let value = subDomain.joined()
                if let totalCount = hashMap[value] {
                    hashMap[value] = totalCount + Int(count) ?? 0
                } else {
                    hashMap[value] = Int(count) ?? 0
                }
                i += 1
            }
        }
        print(hashMap)
        return [""]
    }
}
