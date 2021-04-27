//
//  SearchPlaceViewModel.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation
import CoreLocation

enum SearchFilter {
    case restaraunt
    case liquorStore
    
    var filterString: String {
        switch self {
        case .restaraunt: return "restaurant"
        case .liquorStore: return "liquor store"
        }
    }
}

protocol SearchPlaceViewModelProtocol {
    var appliedFilters: [SearchFilter]? {get set}
    
    func startSession()
    func getList(for string: String, completion: @escaping (SearchViewState) -> Void)
    
    func viewLoaded()
}

struct SearchViewModelState {
    struct PlaceInfo {
        let id: String
        let address: String
        let types: [String]?
    }
    let suggestions: [PlaceInfo]
    let favorites: [PlaceInfo]
}

final class SearchPlaceViewModel: SearchPlaceViewModelProtocol {
    private var dataStorage: MapDataStorageProtocol
    private var currentState: SearchViewModelState
    private let locationManagerDelegate = LocationManagerDelegate()
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = locationManagerDelegate
        return manager
    }()

    var appliedFilters: [SearchFilter]?
    
    init(with storage: MapDataStorageProtocol, filters: [SearchFilter]?) {
        dataStorage = storage
        appliedFilters = filters
        currentState = SearchViewModelState(suggestions: [SearchViewModelState.PlaceInfo](), favorites: [SearchViewModelState.PlaceInfo]())
    }
        
    func viewLoaded() {
        locationManager.delegate = locationManagerDelegate
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func startSession() {
        dataStorage.startSession()
    }
    
    func getList(for string: String, completion: @escaping (SearchViewState) -> Void) {
        dataStorage.getListOfPlaces(for: string, location: locationManager.location?.coordinate) { (result) in
            UISanitize { [weak self] in
                switch result {
                case .success(let state):
                    guard let self = self else { return }
                    let newState = self.fiteredState(from: state)
                    let viewState = SearchViewState(errorMessage: newState.suggestions.count == 0 ? "No places matches your criteria" : nil,
                                                    favorites: PlacesDataSource(with: newState.favorites.map {$0.address}),
                                                    suggestions: PlacesDataSource(with: newState.suggestions.map {$0.address}))
                    self.currentState = newState
                    completion(viewState)
                case .failure(let error):
                    let viewState = SearchViewState(errorMessage: error.message, favorites: nil, suggestions: nil)
                    completion(viewState)
                }
            }
        }
    }
}

private extension SearchPlaceViewModel {
    func fiteredState(from state: SearchViewModelState) -> SearchViewModelState {
        if let filtersStrings = (appliedFilters?.map { $0.filterString }) {
           let newState = SearchViewModelState(suggestions: state.suggestions.filter({(placeInfo) -> Bool in
                if let types = placeInfo.types {
                    return types.filter { (typeString) -> Bool in
                        filtersStrings.contains(typeString)
                    }.count > 0
                }
                return false
            }),
            favorites: state.favorites)
            return newState
        }
        return state
    }
}

private class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
