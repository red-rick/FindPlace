//
//  APIRequest.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol APIRequest {
    var parametersString: String { get }
    var HTTPHeaders: [String: String] { get }
    
    func createURLRequest() throws -> URLRequest
}
