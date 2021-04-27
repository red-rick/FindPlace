//
//  PlaceDetails.swift
//  FindPlace
//
//  Created by Dmytro Benedyk on 22.04.2021.
//

import Foundation

struct PlaceDetails: Decodable {
    let addressComponents: [AddressComponent]?
    let adrAddress: String?
    let formattedAddress: String?
    let formattedPhoneNumber: String?
    let geometry: Geometry
    let icon: String?
    let internationalPhoneNumber: String?
    let name: String?
    let placeId: String?
    let rating: Double?
    let reference: String?
    let reviews: [Review]?
    let types: [String]?
    let url: String?
    let utcOffset: Int
    let vicinity: String?
    let website: String?
    
    struct Review: Decodable {
        let authorName: String?
        let authorUrl: String?
        let language: String?
        let profielPhotoUrl: String?
        let rating: Double?
        let relativeTimeDescription: String?
        let text: String?
        let time: Int?
    }
    
    struct AddressComponent: Decodable {
        let longName: String?
        let shortName: String?
        let types: [String]?
    }
    struct Geometry: Decodable {
        let location: Location?
        let viewport: ViewPort
    }
    
    struct ViewPort: Decodable {
        let northeast: Location?
        let southwest: Location?
    }
    
    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }
}
