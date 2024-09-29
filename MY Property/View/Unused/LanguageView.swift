//
//  LanguageView.swift
//  MY Property
//
//  Created by Akito Daiki on 27/09/2024.
//

import UIKit

class LanguageView: UIView {
    
    // UI Elements
    private let languages = ["English", "Thai", "Myanmar"]
    private var selectedIndex: Int? {
        didSet {
            UserDefaults.standard.set(selectedIndex, forKey: "selectedLanguageIndex")
        }
    }
    
    var onLanguageSelected: ((String) -> Void)?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        loadSelectedLanguage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        loadSelectedLanguage()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "languageCell")
    }
    
    private func loadSelectedLanguage() {
        // Retrieve the selected index from UserDefaults
        selectedIndex = UserDefaults.standard.integer(forKey: "selectedLanguageIndex")
        tableView.reloadData() // Refresh table view to update selection
    }
}

extension LanguageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
        
        // Change the cell appearance based on selection
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
            cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        } else {
            cell.accessoryType = .none
            cell.backgroundColor = .white 
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update selected index to the newly selected index
        selectedIndex = indexPath.row
        
        // Reload the entire table view to update all cells
        tableView.reloadData()
        
        // Call the callback with the selected language
        let selectedLanguage = languages[indexPath.row]
        onLanguageSelected?(selectedLanguage)
    }
}
