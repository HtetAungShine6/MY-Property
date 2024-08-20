//
//  SanityService.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation

class SanityService {
    
    let allProperty = AllProperty()
    
    func fetchAllProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        let query = "*[_type == \"property\"]"
        allProperty.execute(with: query) { result in
            switch result {
            case .success(let propertyResponse):
                completion(.success(propertyResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
