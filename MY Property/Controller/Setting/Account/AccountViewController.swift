//
//  AccountViewController.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 24/9/2567 BE.
//

import Foundation
import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    private let accountView = AccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(accountView)
        accountView.frame = view.bounds
        
        // Configure the view with existing data
        if let user = Auth.auth().currentUser {
            let profileImageURL = user.photoURL?.absoluteString
            let name = user.displayName
            let email = user.email
            accountView.configure(with: profileImageURL, name: name, email: email)
        } else {
            accountView.configure(with: "https://example.com/profile.jpg", name: "John Doe", email: "john@example.com")
        }
    }
    
    func saveUserData() {
        let formData = accountView.getFormData()
        print("Name: \(formData.name ?? "")")
        print("Email: \(formData.email ?? "")")
    }
}
