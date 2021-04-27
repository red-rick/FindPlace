//
//  SearchPlaceViewModel.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation


protocol SearchPlaceViewModelProtocol {
    func startSession()
    func getList(for string: String, completion: @escaping (SearchViewState) -> Void)
}

struct SearchViewModelState {
    struct PlaceInfo {
        let id: String
        let address: String
    }
    let suggestions: [PlaceInfo]
    let favorites: [PlaceInfo]
}

final class SearchPlaceViewModel: SearchPlaceViewModelProtocol {
    private var dataStorage: MapDataStorageProtocol
    private var currentState: SearchViewModelState
    
    init(with storage: MapDataStorageProtocol) {
        dataStorage = storage
        currentState = SearchViewModelState(suggestions: [SearchViewModelState.PlaceInfo](), favorites: [SearchViewModelState.PlaceInfo]())
    }
        
    func startSession() {
        dataStorage.startSession()
    }
    
    func getList(for string: String, completion: @escaping (SearchViewState) -> Void) {
        dataStorage.getListOfPlaces(for: string) { (result) in
            UISanitize { [weak self] in
                switch result {
                case .success(let state):
                    self?.currentState = state
                    let viewState = SearchViewState(errorMessage: nil,
                                                    favorites: PlacesDataSource(with: state.favorites.map {$0.address}),
                                                    suggestions: PlacesDataSource(with: state.suggestions.map {$0.address}))
                    completion(viewState)
                case .failure(let error):
                    let viewState = SearchViewState(errorMessage: error.message, favorites: nil, suggestions: nil)
                    completion(viewState)
                }
            }
        }
    }
}
