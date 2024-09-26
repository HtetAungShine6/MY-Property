//
//  AccountViewController.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 24/9/2567 BE.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    let accountView = AccountView()

    override func loadView() {
        self.view = accountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = .white
        
        // Fetch user data from Firebase
        if let user = Auth.auth().currentUser {
            let profileImageURL = user.photoURL?.absoluteString 
            let name = user.displayName ?? "No Username found"
            let email = user.email ?? "No Email found"
            
            // Configure the account view with user data
            accountView.configure(with: profileImageURL, name: name, email: email)
        } else {
            // Handle the case where the user is not authenticated
            accountView.configure(with: nil, name: "No User", email: "No Email")
        }
    }
}


//import UIKit
//import FirebaseAuth
//
//class AccountViewController: UIViewController {
//
//    let accountView = AccountView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//        view.addSubview(accountView)
//        accountView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            accountView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            accountView.heightAnchor.constraint(equalToConstant: 400)
//        ])
//        
//        if let user = Auth.auth().currentUser {
//            let profileImageURL = user.photoURL?.absoluteString
//            let name = user.displayName ?? "No Username found"
//            let email = user.email ?? "No Email found"
//            
//            // Configure the account view
//            accountView.configure(with: profileImageURL, name: name, email: email)
//        } else {
//            // Handle the case where the user is not authenticated
//            accountView.configure(with: nil, name: "No User", email: "No Email")
//        }
//
//    }
//
//}
