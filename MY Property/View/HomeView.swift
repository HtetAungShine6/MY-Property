//
//  HomeView.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    private let searchIconWidth: CGFloat = 25
    
    lazy var searchIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchIconTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "Search properties placeholder")
        searchBar.backgroundImage = UIImage()
        searchBar.alpha = 0
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
    
    lazy var propertyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        let propertyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        propertyCollectionView.backgroundColor = .white
        return propertyCollectionView
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
        addSubview(propertyCollectionView)
        
        // Setup constraints
        setupConstraints()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        searchIconButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        propertyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
            propertyCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            propertyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            propertyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            propertyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Search Bar Animation
    @objc private func searchIconTapped() {
        if searchBar.alpha == 0 {
            // Show the search bar and change icon to cancel
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.alpha = 1
                self.searchBar.transform = CGAffineTransform(translationX: 0, y: 0)
                self.searchBar.frame.size.width = self.bounds.width - self.searchIconWidth - 20
            }) { _ in
                self.searchBar.transform = .identity
                self.searchIconButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            }
        } else {
            // Hide the search bar and change icon to search
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.frame.size.width = 0
                self.searchBar.alpha = 0
            }) { _ in
                self.searchBar.text = ""
                self.searchIconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            }
        }
    }
}




//class HomeView: UIView {
//    
//    lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "Search properties placeholder")
//        searchBar.backgroundImage = UIImage()
//        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
//            searchTextField.font = UIFont(name: "Fredoka-Light", size: 16)
//            searchTextField.textColor = .black
//            
//            if let placeholderLabel = searchTextField.value(forKey: "placeholderLabel") as? UILabel {
//                placeholderLabel.font = UIFont(name: "Fredoka-Light", size: 16)
//                placeholderLabel.textColor = .lightGray
//            }
//        }
//        return searchBar
//    }()
//    
//    lazy var propertyCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 16
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
//        
//        let propertyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        propertyCollectionView.backgroundColor = .white
//        return propertyCollectionView
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
//        addSubview(propertyCollectionView)
//        
//        // Setup constraints
//        setupConstraints()
//    }
//    
//    // MARK: - Constraints Setup
//    private func setupConstraints() {
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        propertyCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
//            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            
//            propertyCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
//            propertyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            propertyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            propertyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//}
