//
//  Place.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

struct Place: Decodable {
    let description: String
    let distanceMeters: Int?
    let matchedSubstrings: [Substring]?
    let placeId: String
    let reference: String
    let terms: [Term]?
    let types: [String]?
    
    struct Substring: Decodable {
        let length: Int?
        let offset: Int?
    }
    
    struct Term: Decodable {
        let offset: Int?
        let value: String?
    }
}
