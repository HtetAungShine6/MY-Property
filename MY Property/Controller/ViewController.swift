//
//  ViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let sanityService = SanityService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GetProperty()
    }
}

extension ViewController {
    private func GetProperty() {
        sanityService.fetchAllProperties { result in
            switch result {
            case .success(let properties):
                for property in properties {
                    print("Property: \(property)")
                }
            case .failure(let error):
                print("Failed to fetch properties: \(error.localizedDescription)")
            }
        }
    }
}
