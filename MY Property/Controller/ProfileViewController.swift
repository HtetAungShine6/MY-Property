//
//  ProfileViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let googleService = GoogleService()
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("sign_out", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Fredoka-Regular", size: 16)
        return button
    }()
    
    let tableData: [String] = {
        return [
            NSLocalizedString("account_cell", comment: "Account"),
            NSLocalizedString("favorite_cell", comment: "Favorites")
        ]
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationTitle()
        setupTableView()
        setupSignOutButton()
        setupLayout()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupNavigationTitle() {
        self.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Fredoka-Regular", size: 34)!,
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    func setupSignOutButton() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
    func setupLayout() {
        // Add both the tableView and the signOutButton to the view
        view.addSubview(tableView)
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -16),
            
            signOutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func signOut() {
        let alertController = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.googleService.signOutWithGoogle()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Fredoka-Light", size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let accountVC = AccountViewController()
            navigationController?.pushViewController(accountVC, animated: true)
        case 1:
            let favoritesVC = FavoritesViewController()
            navigationController?.pushViewController(favoritesVC, animated: true)
        default:
            break
        }
    }
}
