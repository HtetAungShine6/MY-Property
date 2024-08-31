//
//  HomeView.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search properties"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    lazy var propertyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
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
        addSubview(searchBar)
        addSubview(propertyCollectionView)
        
        // Setup constraints
        setupConstraints()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        propertyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            propertyCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            propertyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            propertyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            propertyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
