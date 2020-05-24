//
//  Helper.swift
//  NetworkSession
//
//  Created by Ajith Anthony on 4/27/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

public func showAlert(title: String?, message: String?, style: UIAlertController.Style) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    guard let window = UIApplication.shared.delegate?.window else { return }
    window?.rootViewController?.present(alert, animated: true, completion: nil)
}
