//
//  Coordinator.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

protocol Coordiantor {
    var childCoordinators: [Coordiantor] { get set }
    
    func start()
}
