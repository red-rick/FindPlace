//
//  ModuleFactory.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import UIKit

protocol FindPlaceModulesFactoryProtocol {
    func createPlaceSearch() throws -> UIViewController
    func createPlaceDetails() throws -> UIViewController
}

struct FindPlaceModulesFactory: FindPlaceModulesFactoryProtocol {
    private struct Constants {
        static let storyaboardName = "MainStoryboard"
        
        static let searchConotrollerId = "SearchPlaceViewController"
        static let detailsControllerId = ""
    }
    private let storyboard = UIStoryboard(name: Constants.storyaboardName, bundle: nil)
    
    
    func createPlaceSearch() throws -> UIViewController {
        if let viewController = storyboard.instantiateViewController(identifier: Constants.searchConotrollerId) as? SearchPlaceViewController {
            viewController.viewModel = SearchPlaceViewModel()
            return viewController
        } else {
            let error: CommonError = .cannotInitalizeController
            throw error
        }
    }
    
    func createPlaceDetails() throws -> UIViewController {
        UIViewController()
    }
}
