//
//  TableviewDQueue.swift
//  Practice
//
//  Created by Ajith Anthony on 6/30/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation
import UIKit

class UITableView: UIScrollView {
  
  private var cellQueues = [String: Queue<UITableViewCell>]()
  
  func dequeueReusableCell(withIdentifier identifier: String,
                           for indexPath: IndexPath) -> UITableViewCell  {
    
    guard let cellQueue = cellQueues[identifier] else {
      fatalError("No UITableViewCell is registered for this identifier")
    }
    
    if let cell = cellQueue.dequeue() {
      return cell
    }
    
    return UITableViewCell(style: .default,
                           reuseIdentifier: identifier)
  }
}

class Queue<T> {
  
  private var storage: [T] = [T]()
  
  func enqueue(item: T) {
    storage.insert(item, at: 0)
  }
  
  func dequeue() -> T? {
    return storage.popLast()
  }
}
