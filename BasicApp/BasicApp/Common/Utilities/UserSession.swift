//
//  UserSession.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/19/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class UserSession {
    static let shared = UserSession()
    var userdefaults = UserDefaults.standard
    
    var userToken: String {
        get {
            userdefaults.value(forKey: "Token") as? String ?? ""
        }
        set {
            userdefaults.set(newValue, forKey: "Token")
        }
    }
}
