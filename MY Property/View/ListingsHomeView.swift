//
//  ListingsHomeView.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 2/9/2567 BE.
//

import Foundation
import UIKit

class ListingsHomeView: UIView {
    
    private let searchIconWidth: CGFloat = 25 // Width of the search icon

    lazy var searchIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchIconTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "Search listings placeholder")
        searchBar.backgroundImage = UIImage()
        searchBar.alpha = 0 // Initially hidden
        
        // Customize the search text field
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.font = UIFont(name: "Fredoka-Light", size: 16)
            searchTextField.textColor = .black
            
            if let placeholderLabel = searchTextField.value(forKey: "placeholderLabel") as? UILabel {
                placeholderLabel.font = UIFont(name: "Fredoka-Light", size: 16)
                placeholderLabel.textColor = .lightGray
            }
        }
        return searchBar
    }()
    
    lazy var listingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        let listingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listingCollectionView.backgroundColor = .white
        return listingCollectionView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .white
        
        // Add subviews
        addSubview(searchIconButton)
        addSubview(searchBar)
        addSubview(listingCollectionView)
        
        // Setup constraints
        setupConstraints()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        searchIconButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        listingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Align search icon button to the left side
            searchIconButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchIconButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchIconButton.widthAnchor.constraint(equalToConstant: searchIconWidth),
            searchIconButton.heightAnchor.constraint(equalToConstant: searchIconWidth),
            
            // Set up the search bar
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: searchIconButton.trailingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            // Property collection view constraints
            listingCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            listingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Search Icon Animation
    @objc private func searchIconTapped() {
        if searchBar.alpha == 0 {
            // Show the search bar and change icon to cancel
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.alpha = 1
                self.searchIconButton.setImage(UIImage(systemName: "xmark"), for: .normal) // Change to cancel icon
            })
        } else {
            // Hide the search bar and change icon to search
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.alpha = 0
            }) { _ in
                self.searchBar.text = ""
                self.searchBar.resignFirstResponder()
                self.searchIconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // Change back to search icon
            }
        }
    }
}

//import Foundation
//import UIKit
//
//class ListingsHomeView: UIView {
//    
//    lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Search listings"
//        searchBar.backgroundImage = UIImage()
//        return searchBar
//    }()
//    
//    lazy var listingCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 16
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
//        
//        let listingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        listingCollectionView.backgroundColor = .white
//        listingCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        listingCollectionView.showsHorizontalScrollIndicator = false
//        return listingCollectionView
//    }()
//    
//    // MARK: - Initializer
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//    
//    // MARK: - UI Setup
//    private func setupUI() {
//        backgroundColor = .white
//        
//        // Add subviews
//        addSubview(searchBar)
//        addSubview(listingCollectionView)
//        
//        // Setup constraints
//        setupConstraints()
//    }
//    
//    // MARK: - Constraints Setup
//    private func setupConstraints() {
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        listingCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
//            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            
//            listingCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
//            listingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            listingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            listingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            
//        ])
//    }
//}
