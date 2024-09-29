//
//  KeychainManager.swift
//  MY Property
//
//  Created by Akito Daiki on 26/09/2024.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    static let shared = KeychainManager()
    
    let keychain = KeychainSwift()
    
    private init() {}
}
