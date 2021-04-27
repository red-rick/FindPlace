//
//  DataStorage.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol MapDataStorageProtocol {
    func startSession()
    
    func getListOfPlaces(for searchString: String, completion: @escaping (Result<[Place], APIError>) -> Void)
    func getPlaceDetails(for placeId: String, completion: @escaping (Result<PlaceDetails, APIError>) -> Void)
}

struct APIListOfPlacesResponse: Decodable {
    let status: String?
    let predictions: [Place]?
}

final class MapDataStorage: MapDataStorageProtocol {
    static let shared = MapDataStorage()
    
    private let apiService: APIServiceProtocol
    private var sessionId: UUID?
    
    private init() {
        apiService = APIService()
    }
    
    func startSession() {
        sessionId = UUID()
    }
    
    func getListOfPlaces(for searchString: String, completion: @escaping (Result<[Place], APIError>) -> Void) {
        let parameters = FindPlaceParameters(input: searchString,
                                             key: APIKey,
                                             sessionToken: sessionId?.uuidString,
                                             offset: nil,
                                             origin: nil,
                                             location: nil,
                                             radius: nil,
                                             language: nil,
                                             types: nil,
                                             comoponents: nil)
        apiService.performRequest(APIMapRequest.findPlace(parameters)) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let responseObject = try decoder.decode(APIListOfPlacesResponse.self, from: data)
                    if let places = responseObject.predictions {
                        completion(.success(places))
                    } else {
                        completion(.failure(.cannotParseResponse))
                    }
                } catch (_) {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPlaceDetails(for placeId: String, completion: @escaping (Result<PlaceDetails, APIError>) -> Void) {
        
    }
    
}
