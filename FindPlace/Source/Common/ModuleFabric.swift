//
//  ModuleFabric.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import UIKit

protocol FindPlaceModuleFabricProtocol {
    func createPlaceSearch() -> UIViewController
    func createPlaceDetails() -> UIViewController
}

final class FindPlaceModuleFabric: FindPlaceModuleFabricProtocol {
    func createPlaceSearch() -> UIViewController {
        UIViewController()
    }
    
    func createPlaceDetails() -> UIViewController {
        UIViewController()
    }
}
