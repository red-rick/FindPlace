//
//  APIService.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol APIError: Error {
    var message: String { get }
}

protocol APIService {
    func performRequest(_ request: APIRequest, completion: (Result<Data, Error>))
}
