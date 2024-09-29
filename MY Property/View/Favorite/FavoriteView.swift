//
//  FavoriteView.swift
//  MY Property
//
//  Created by Akito Daiki on 26/09/2024.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    
    lazy var favoriteListingCollectionView: UICollectionView = {
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
        addSubview(favoriteListingCollectionView)
        
        // Setup constraints
        setupConstraints()
    }
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        favoriteListingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            favoriteListingCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            favoriteListingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteListingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteListingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
