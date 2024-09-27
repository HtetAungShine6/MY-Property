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


//import UIKit
//import FirebaseAuth
//
//class AccountViewController: UIViewController {
//
//    let accountView = AccountView()
//
//    override func loadView() {
//        self.view = accountView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set the background color
//        view.backgroundColor = .white
//        
//        // Fetch user data from Firebase
//        if let user = Auth.auth().currentUser {
//            let profileImageURL = user.photoURL?.absoluteString 
//            let name = user.displayName ?? "No Username found"
//            let email = user.email ?? "No Email found"
//            
//            // Configure the account view with user data
//            accountView.configure(with: profileImageURL, name: name, email: email)
//        } else {
//            // Handle the case where the user is not authenticated
//            accountView.configure(with: nil, name: "No User", email: "No Email")
//        }
//        
//    }
//}
