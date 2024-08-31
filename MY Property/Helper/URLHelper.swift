//
//  URLHelper.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import Foundation

func buildImageURL(from partialURL: String) -> URL? {
    
    let cleanedURLString = partialURL.replacingOccurrences(of: "image-", with: "")
    let formattedURLString = cleanedURLString.replacingOccurrences(of: "-jpg", with: ".jpg")
    let fullURLString = "https://cdn.sanity.io/images/gejbm6fo/production/\(formattedURLString)"
    
    return URL(string: fullURLString)
}
