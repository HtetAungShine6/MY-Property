//
//  PropertyResponse.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation
import Alamofire

struct PropertyResponse: Codable {
    let result: [Property]
}

struct Property: Codable {
    let _id: String
    let _createdAt: String
    let _updatedAt: String
    let _rev: String
    let title: String
    let slug: Slug
    let description: String
    let minPrice: Double
    let maxPrice: Double
    let propertyHero: ImageAsset
    let photos: [ImageAsset]?
    let facilities: [Facility]?

    struct Slug: Codable {
        let current: String
    }

    struct ImageAsset: Codable {
        let asset: AssetReference

        struct AssetReference: Codable {
            let _ref: String?
        }
    }

    struct Facility: Codable {
        let facilityType: String
        let facilityName: String?
        let description: String?
        let photos: [ImageAsset]?
    }
}
