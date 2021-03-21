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
    let linkedList = LinkedList()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 1...10 {
            linkedList.addNode(LinkedListNode(i))
        }
        
        findLinkedList(for: 4, head: linkedList.head, index: 1)
    }
    
    func findLinkedList(for position: Int, head: LinkedListNode?, index: Int) {
        var headNode = head
        var index = 0
        while index < position {
            headNode = headNode?.right
            index += 1
        }
        print(headNode?.value)
        print(headNode?.right?.value)
        print(headNode?.left?.value)
    }
}
