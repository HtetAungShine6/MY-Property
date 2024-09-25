//
//  app_utility.swift
//  MY Property
//
//  Created by Akito Daiki on 25/08/2024.
//

import Foundation
import UIKit

//MARK: - Dependency Injection with UIViewController for UI
final class Application_utility {
    
    static var rootViewController: UIViewController{
        
        //MARK: - View will lead to the google sign-in link got from Firebase
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

