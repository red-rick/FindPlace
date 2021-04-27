//
//  APIMapRequest.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation
import CoreLocation

struct FindPlaceParameters {
    let input: String
    let key: String
    let sessionToken: String?
    let offset: String?
    let origin: String?
    let location: CLLocationCoordinate2D?
    let radius: Int?
    let language: String?
    let types: [String]?
    let comoponents: [String]?
    
    var urlComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        components.append(URLQueryItem(name: "input", value: input))
        components.append(URLQueryItem(name: "key", value: key))
        if let token = sessionToken {
            components.append(URLQueryItem(name: "sessiontoken", value: token))
        }
        return components
    }
}

struct PlaceDetailsParameters {
    let key: String
    let placeId: String
    let language: String?
    let region: String?
    let sessionToken: String?
    let filelds: [String]?
    
    var urlComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        components.append(URLQueryItem(name: "place_id", value: placeId))
        components.append(URLQueryItem(name: "key", value: key))
        if let token = sessionToken {
            components.append(URLQueryItem(name: "sessiontoken", value: token))
        }
        return components
    }
}


enum APIMapRequest: APIRequestProtocol {
    case findPlace(FindPlaceParameters)
    case placeDetails(PlaceDetailsParameters)
    
    var baseUrl: String {
        return "https://maps.googleapis.com/maps/api/place/"
    }
    
    var path: String {
        switch self {
        case .findPlace: return "autocomplete/json"
        case .placeDetails: return "details/json"
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .findPlace(let parameters): return parameters.urlComponents
        case .placeDetails(let parameters): return parameters.urlComponents
        }
    }
    
    var HTTPHeaders: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    func createURLRequest() throws -> URLRequest {
        if var urlComponents = URLComponents(string: baseUrl + path) {
            if let parameters = queryParameters {
                urlComponents.queryItems = parameters
            }
            if let url = urlComponents.url {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.allHTTPHeaderFields = HTTPHeaders
                
                return request
            } else {
                throw APIError.cannotCreateRequest
            }
        } else {
            throw APIError.cannotCreateRequest
        }
    }
}
