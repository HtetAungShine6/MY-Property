//
//  SanityService.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation

class SanityService {
    
    let allProperty = AllProperty()
    let allListing = AllListing()
    
    func fetchAllProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        let query = "*[_type == \"property\"]"
        allProperty.execute(with: query) { result in
            switch result {
            case .success(let propertyResponse):
                print("FETCHED PROPERTIES")
                completion(.success(propertyResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllListing(completion: @escaping (Result<[Listing], Error>) -> Void) {
        let query = "*[_type == \"listing\"]"
        allListing.execute(with: query) { result in
            switch result {
            case .success(let listingResponse):
                print("FETCHED LISTINGS: \(result)")
                completion(.success(listingResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
