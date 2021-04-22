//
//  MainCoordinator.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import UIKit

final class MainCoordinator: CoordiantorProtocol {
    private let modulesFactory = FindPlaceModulesFactory()
    private var window: UIWindow
    
    var childCoordinators: [CoordiantorProtocol] = [CoordiantorProtocol]()
    
    func start() {
        do {
            let viewController = try modulesFactory.createPlaceSearch()
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
        catch( _ ) {
            NSLog("Cannot start coordinator")
        }
    }
    
    init(with mainWindow: UIWindow) {
        window = mainWindow
    }
}
