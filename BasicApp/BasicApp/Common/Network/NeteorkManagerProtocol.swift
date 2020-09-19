//
//  NeteorkManagerProtocol.swift
//  BasicApp
//
//  Created by Ajith Anthony on 9/19/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import Foundation

enum HTTPResponseError: Error {
    case Informational
    case isSuccess
    case isRedirection
    case isClientError
    case isServerError
    case unknown
}

protocol NeteorkManagerProtocol {
    func setURLRequest<T: Codable>(for url: URL, model: T) -> URLRequest
    func handleURLResponse(_ response: HTTPURLResponse) -> Error
}

extension NeteorkManagerProtocol {
    func handleURLResponse(_ response: HTTPURLResponse) -> Error {
        switch response.statusCode {
        case 100...199:
            return HTTPResponseError.Informational
        case 200...299:
            return HTTPResponseError.isSuccess
        case 300...399:
            return HTTPResponseError.isRedirection
        case 400...499:
            return HTTPResponseError.isClientError
        case 500...599:
            return HTTPResponseError.isServerError
        default:
            return HTTPResponseError.unknown
        }
    }
    
    func setURLRequest<T: Codable>(for url: URL, model: T) -> URLRequest {
        var request = URLRequest(url: url)
        // Http Type
        request.httpMethod = "POST"
        // Http header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("token", forHTTPHeaderField: UserSession.shared.userToken)
        // request data
        let jsonData = try? JSONEncoder().encode(model)
        request.httpBody = jsonData
        return request
    }
}
