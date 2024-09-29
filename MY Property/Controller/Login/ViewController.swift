//
//  ViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import UIKit

class ViewController: UIViewController {
    
    let loginView = LoginScreen()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
