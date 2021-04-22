//
//  Coordinator.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol CoordiantorProtocol {
    var childCoordinators: [CoordiantorProtocol] { get set }
    
    func start()
}
