//
//  PlacesDataSource.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 26.04.2021.
//

import Foundation

struct PlacesDataSource: DataSourceProtocol {
    typealias Item = String
    
    private let titles: [String]
    
    init(with list: [String]) {
        titles = list
    }
    
    var numberOfSections: Int { 1 }
    
    func numberOfItems(at section: Int) -> Int {
        return titles.count
    }
    
    func item(at index: Int) -> String {
        return titles[index]
    }
}
