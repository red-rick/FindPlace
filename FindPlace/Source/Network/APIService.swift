//
//  APIService.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

enum APIError: Error {
    case cannotCreateRequest
    case cannotParseResponse
    case serverError
    case unknown
    
    var message: String {
        switch self {
        case .cannotCreateRequest: return "Cannot create request"
        case .cannotParseResponse: return "Cannot parse response"
        case .serverError: return "Better call Soul"
        case .unknown: return "Unknwon error"
        }
    }
}

enum HTTPStatusCode: Int {
    case ok = 200
}

let APIKey = "AIzaSyBgOWgGoM7bHob_kpXnyN2cIdtby71TZsc"

protocol APIServiceProtocol {
    func performRequest(_ request: APIRequestProtocol, completion: @escaping (Result<Data, APIError>) -> Void)
}

struct APIService: APIServiceProtocol {
    func performRequest(_ request: APIRequestProtocol, completion: @escaping (Result<Data, APIError>) -> Void) {
        do {
            let urlRequest = try request.createURLRequest()
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse,
                   HTTPStatusCode(rawValue: httpResponse.statusCode) == .ok,
                   let responseData = data {
                    completion(.success(responseData))
                } else {
                    completion(.failure(.serverError))
                }
            }).resume()
        } catch(let error) {
            if let apiError = error as? APIError {
                completion(.failure(apiError))
            } else {
                completion(.failure(APIError.unknown))
            }
        }
    }
}
