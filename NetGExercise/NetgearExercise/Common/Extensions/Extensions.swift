//
//  Extensions.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import Foundation
import UIKit

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    private var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    private var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    private var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

extension UIViewController {
    func showAlert(title: String? = "Alert", message: String?, buttonTitle: String = "Ok", completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action:UIAlertAction) in
            completion?(action)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
