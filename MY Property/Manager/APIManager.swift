//
//  APIManager.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation
import Alamofire

protocol APIManager: AnyObject {
    associatedtype ModelType: Codable
    var methodPath: String { get }
}

extension APIManager {
    
    var url: URL {
        let urlString = "https://gejbm6fo.api.sanity.io/v1/data/query/production" + methodPath
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return url
    }
    
    func execute(with query: String, completion: @escaping(Result<ModelType, Error>) -> Void) {
        let urlString = "\(url)?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        AF.request(urlString).validate(statusCode: 200..<300).responseDecodable(of: ModelType.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                print("Successfully fetched data: \(data)")
            case .failure(let error):
                completion(.failure(error))
                print("Request error: \(error)")
            }
        }
    }
}
