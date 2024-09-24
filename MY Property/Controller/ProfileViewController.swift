//
//  ProfileViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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

    }
    
    
    
}


