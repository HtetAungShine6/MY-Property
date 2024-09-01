//
//  ListingsHomeView.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 2/9/2567 BE.
//

import Foundation
import UIKit

class ListingsHomeView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search listings"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    lazy var listingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        let listingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listingCollectionView.backgroundColor = .white
        listingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listingCollectionView.showsHorizontalScrollIndicator = false
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
        addSubview(searchBar)
        addSubview(listingCollectionView)
        
        // Setup constraints
        setupConstraints()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        listingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            listingCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            listingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
