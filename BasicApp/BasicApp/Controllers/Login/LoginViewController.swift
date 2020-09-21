//
//  LoginViewController.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginModel = LoginData()
    var currentTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        view.endEditing(true)
        loginModel.login { (result) in
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                self.showAlert(title: "Invalid Credentials", message: error.errorDescription)
            }
        }
    }
    
    func updateModel(from textField: UITextField) {
        if textField.tag == 1 {
            loginModel.userName = textField.text ?? ""
        } else {
            loginModel.password = textField.text ?? ""
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentTextField = textField
        updateModel(from: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        currentTextField = textField
        updateModel(from: textField)
        return true
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
