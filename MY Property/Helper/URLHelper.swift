//
//  URLHelper.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import Foundation

func buildImageURL(from partialURL: String) -> URL? {
    
    var cleanedURLString = partialURL.replacingOccurrences(of: "image-", with: "")
    cleanedURLString = cleanedURLString.replacingOccurrences(of: "-jpg", with: ".jpg")
    cleanedURLString = cleanedURLString.replacingOccurrences(of: "-jpeg", with: ".jpeg")
    cleanedURLString = cleanedURLString.replacingOccurrences(of: "-png", with: ".png")
    cleanedURLString = cleanedURLString.replacingOccurrences(of: "-webp", with: ".webp")
    
    let fullURLString = "https://cdn.sanity.io/images/gejbm6fo/production/\(cleanedURLString)"
    print(fullURLString)
    return URL(string: fullURLString)
}
