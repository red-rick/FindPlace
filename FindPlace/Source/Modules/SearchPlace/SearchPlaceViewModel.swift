//
//  SearchPlaceViewModel.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

struct SearchViewState {
    let suggestions: PlacesDataSource
    let favorites: PlacesDataSource
}

protocol SearchPlaceViewModelProtocol: ViewModelProtocol {
    func startSession()
    func getList(for string: String, completion: @escaping (Result<[String], APIError>) -> Void)
}

final class SearchPlaceViewModel: SearchPlaceViewModelProtocol {
    private var dataStorage: MapDataStorageProtocol
    private var places: [Place]?
    private var observer: ViewProtocol?
    
    init(with storage: MapDataStorageProtocol) {
        dataStorage = storage
    }
    
    func assignStateObserver(_ view: ViewProtocol?) {
        observer = view
    }
        
    func startSession() {
        dataStorage.startSession()
    }
    
    func getList(for string: String, completion: @escaping (Result<[String], APIError>) -> Void) {
        dataStorage.getListOfPlaces(for: string) { (result) in

        }
    }
}
