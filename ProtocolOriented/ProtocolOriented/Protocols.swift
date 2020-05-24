//
//  Protocols.swift
//  ProtocolOriented
//
//  Created by Ajith Anthony on 5/26/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

protocol Protocols {
    var name: String { get set }
    
    //func showName()
}

extension Protocols {
    func showName() {
        print(name)
    }
}
