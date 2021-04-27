//
//  ViewProtocol.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 26.04.2021.
//

import Foundation

protocol ViewProtocol {
    func render<State>(state: State)
}
