//
//  ProfileViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    
    let tableData = ["Accounts", "Favorites", "Language"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let accountVC = AccountViewController()
            navigationController?.pushViewController(accountVC, animated: true)
            
        case 1:
            let favoritesVC = FavoritesViewController()
            navigationController?.pushViewController(favoritesVC, animated: true)
            
        case 2:
            let languageVC = LanguageViewController()
            navigationController?.pushViewController(languageVC, animated: true)
            
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        setupSignOutButton()
    }
    
    func setupSignOutButton() {
        // Add the button to the view
        view.addSubview(signOutButton)
        
        // Set button constraints or frame
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 100),
            signOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Add action for sign-out
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
    @objc func signOut() {
//        // Call the sign out function from GoogleService
        let googleService = GoogleService()
        googleService.printKeychainData()
//        
//        // Optionally, navigate to the login screen or show an alert
//        let alert = UIAlertController(title: "Signed Out", message: "You have been signed out successfully.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//            // Navigate back to login or main screen if necessary
//            // e.g., self.navigationController?.popToRootViewController(animated: true)
//        })
//        self.present(alert, animated: true)
        
    }
    
    
}


