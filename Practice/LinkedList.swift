//
//  LinkedList.swift
//  Practice
//
//  Created by Ajith Anthony on 3/18/21.
//  Copyright © 2021 Ajith Antony. All rights reserved.
//

import Foundation

// MARK: 1. LRU Cache
class Node{
    var pre: Node?
    var next: Node?
    var key: Int
    var value: Int
    init(_ key: Int, _ value: Int){
        self.key = key
        self.value = value
    }
}

class LRUCache {
    var capacity: Int
    var head: Node?
    var tail: Node?
    var count: Int
    var map: [Int : Node]
    init(_ capacity: Int) {
        self.capacity = capacity
        head = Node(-1, -1)
        tail = Node(-1, -1)
        head?.next = tail
        tail?.pre = head
        count = 0
        map = [Int: Node]()
    }
    
    func moveToHead(_ node: Node?){
        node?.next = head?.next
        head?.next?.pre = node
        node?.pre = head
        head?.next = node
    }
    
    func deleteNode(_ node: Node?){
        node?.next?.pre = node?.pre
        node?.pre?.next = node?.next
    }
    
    func get(_ key: Int) -> Int {
        if(map[key] == nil){
            return -1
        }
        var node = map[key]
        deleteNode(node)
        moveToHead(node)
        return node!.value
    }
    
    func put(_ key: Int, _ value: Int) {
        
        if(map[key] != nil){
            var node = map[key]
            node?.value = value
            deleteNode(node)
            moveToHead(node)
            return
        }
        
        var node = Node(key, value)
        map[key] = node
        if(count == capacity){
            var delete = tail?.pre
            deleteNode(delete)
            map[delete!.key] = nil
            count -= 1
        }
        moveToHead(node)
        count+=1
      
    }
}
