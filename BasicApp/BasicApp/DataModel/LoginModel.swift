//
//  LoginModel.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/20/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case missingInputs
    case invalidUserName
    case invalidPassword
    
    var errorDescription: String {
        switch self {
        case .invalidPassword:
            return "Invalid Password"
        case .invalidUserName:
            return "Invalid User Name"
        case .missingInputs:
            return "Missing Inputs"
        }
    }
}

struct LoginData {
    var userName: String = ""
    var password: String = ""
    
    func login(completion: @escaping (Result<LoginResponse, LoginError>) -> Void) {
        guard isValudateData() else { return completion(.failure(LoginError.missingInputs)) }
        //API
    }
    
    func isValudateData() -> Bool {
        return (userName.isEmpty || password.isEmpty) ? false : true
    }
}

struct LoginResponse {
    
}
