//
//  DataSourceProtocol.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 26.04.2021.
//

import Foundation

protocol DataSourceProtocol {
    associatedtype Item
    var numberOfSections: Int { get }
    func numberOfItems(at section: Int) -> Int
    func item(at index: Int) -> Item
}
