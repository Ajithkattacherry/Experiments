//
//  NetworkManager.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case dataEncodeFailed(error: Error)
    case httpError(stausCode: Int)
    case defultError(error: Error)
}

protocol CustomSequence: Sequence, IteratorProtocol {
    var item: Array<Int>?
}

protocol NetworkManagerProtocol {
    func execute<T: Codable>(urlString: String,
                             request: URLRequest?,
                             completion: @escaping (Result<T, NetworkError>)-> Void)
    func loadImage(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension NetworkManagerProtocol {
    func execute<T: Codable>(urlString: String,
                             request: URLRequest? = nil,
                             completion: @escaping (Result<T, NetworkError>)-> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.invalidURL))
        }
        executeGetService(url: url, completion: completion)
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: url)
        request.addValue("33626b03-88b8-4c6e-af34-ac4e6f7faa7c", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.defultError(error: error)))
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(.failure(NetworkError.httpError(stausCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    return completion(.failure(NetworkError.invalidResponse))
                }
                completion(.success(data))
            }
        }.resume()
    }
    
    private func executeGetService<T: Codable>(url: URL,
                                               completion: @escaping (Result<T, NetworkError>)-> Void) {
        guard let request = createGetURLRequestHeader(for: url) else {
            return completion(.failure(NetworkError.invalidRequest))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.defultError(error: error)))
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(.failure(NetworkError.httpError(stausCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    return completion(.failure(NetworkError.invalidResponse))
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(NetworkError.dataEncodeFailed(error: error)))
                }
            }
        }.resume()
    }
    
    private func createGetURLRequestHeader(for url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("33626b03-88b8-4c6e-af34-ac4e6f7faa7c", forHTTPHeaderField: "X-API-KEY")
        return request
    }
}
