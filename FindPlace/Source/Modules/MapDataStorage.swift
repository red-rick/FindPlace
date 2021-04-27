//
//  DataStorage.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol MapDataStorageProtocol {
    func startSession()
    func endSession()
    
    func getListOfPlaces(for searchString: String, completion: @escaping (Result<SearchViewModelState, APIError>) -> Void)
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
    
    func endSession() {
        sessionId = nil
    }
    
    func getListOfPlaces(for searchString: String, completion: @escaping (Result<SearchViewModelState, APIError>) -> Void) {
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
                        let state = SearchViewModelState(suggestions: places.map { SearchViewModelState.PlaceInfo(id: $0.placeId, address: $0.description) }, favorites: [])
                        completion(.success(state))
                    } else {
                        completion(.failure(.cannotParseResponse))
                    }
                } catch (_) {
                    completion(.failure(.cannotParseResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPlaceDetails(for placeId: String, completion: @escaping (Result<PlaceDetails, APIError>) -> Void) {
        
    }
    
}
