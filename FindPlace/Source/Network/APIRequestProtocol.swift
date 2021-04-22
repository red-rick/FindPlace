//
//  APIRequest.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol APIRequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var queryParameters: [URLQueryItem]? { get }
    var HTTPHeaders: [String: String] { get }
    
    func createURLRequest() throws -> URLRequest
}
