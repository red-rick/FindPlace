//
//  SearchViewModelTests.swift
//  FindPlaceTests
//
//  Created by Dmytro Benedyk on 27.04.2021.
//

import XCTest
import CoreLocation
@testable import FindPlace

class SearchViewModelTests: XCTestCase {
    private var searchViewModel: SearchPlaceViewModel!
    private var storageMock: MapStorageMock!
    
    override func setUpWithError() throws {
        storageMock = MapStorageMock()
    }

    override func tearDownWithError() throws {
        storageMock = nil
        searchViewModel = nil
    }

    func testSuccessSeachr() throws {
        storageMock.modelState = createTestState()
        searchViewModel = SearchPlaceViewModel(with: storageMock, filters: [.restaraunt])
        searchViewModel.getList(for: "T") { (state) in
            XCTAssertEqual(state.suggestions?.numberOfItems(at: 0), 1)
        }
    }
}

private class MapStorageMock: MapDataStorageProtocol {
    var modelState: SearchViewModelState!
    
    func startSession() { }
    
    func endSession() { }
    
    func getListOfPlaces(for searchString: String, location: CLLocationCoordinate2D?, completion: @escaping (Result<SearchViewModelState, APIError>) -> Void) {
        
    }
    
    func getPlaceDetails(for placeId: String, completion: @escaping (Result<PlaceDetails, APIError>) -> Void) {
    }
}

private extension SearchViewModelTests {
    func createTestState() -> SearchViewModelState {
        return SearchViewModelState(suggestions: [SearchViewModelState.PlaceInfo(id: "12324", address: "Test Address", types: ["restaurant"])], favorites: [])
    }
}
