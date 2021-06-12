//
//  Service.swift
//  ProductsApp
//
//  Created by Furkan Kaan Ugsuz on 11/06/2021.
//

import Foundation

class APIService {
    
    static func callService<T: Codable>(request: RequestProtocol, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = request.url else {
            completion(.failure(.serviceError))
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        if let parameters = request.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let data = data else {
                completion(.failure(.serviceError))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}

enum APIError: Error {
    case serviceError
    case noNetwork
    case decodingError
    
    var message: String {
        switch self {
        case .serviceError:
            return "Could not connect to the server. Please try again later."
        default:
            return "An error occured. Please try again later."
        }
    }
}

protocol RequestProtocol {
    var url: URL? { get set }
    var method: RequestMethod { get set }
    var parameters: [String: Any]? { get set }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
