//
//  ListingDetailView.swift
//  MY Property
//
//  Created by Akito Daiki on 24/09/2024.
//

import Foundation
import UIKit
import MapKit

class ListingDetailView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var isFavorited = false
    
    lazy var listingDetailImage: UIImageView = {
        let listingDetailImage = UIImageView()
        listingDetailImage.contentMode = .scaleAspectFill
        listingDetailImage.clipsToBounds = true
        return listingDetailImage
    }()
    
    lazy var listingNameLabel: UILabel = {
        let listingNameLabel = UILabel()
        listingNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        listingNameLabel.textColor = .black
        return listingNameLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        return descriptionLabel
    }()
    
    lazy var facilitiesPlaceholderLabel: UILabel = {
        let facilitiesPlaceholderLabel = UILabel()
        facilitiesPlaceholderLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        facilitiesPlaceholderLabel.textColor = .black
        return facilitiesPlaceholderLabel
    }()
    
    lazy var facilitiesLabel: UILabel = {
        let facilitiesLabel = UILabel()
        facilitiesLabel.font = UIFont.systemFont(ofSize: 16)
        facilitiesLabel.textColor = .black
        return facilitiesLabel
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = false
        return mapView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        return button
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
    
    private func setupUI() {
        backgroundColor = .white
        
        // Add Views
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(listingDetailImage)
        contentView.addSubview(listingNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(facilitiesPlaceholderLabel)
        contentView.addSubview(facilitiesLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(mapView)
        
        // Setup constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        listingDetailImage.translatesAutoresizingMaskIntoConstraints = false
        listingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        facilitiesPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        facilitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints for scroll view
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constraints for content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Constraints for listingDetailImage
            listingDetailImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingDetailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listingDetailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listingDetailImage.heightAnchor.constraint(equalToConstant: 200),
            
            // Constraints for favoriteButton (placed below image on the right side)
            favoriteButton.topAnchor.constraint(equalTo: listingDetailImage.bottomAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Constraints for listingNameLabel
            listingNameLabel.topAnchor.constraint(equalTo: listingDetailImage.bottomAnchor, constant: 10),
            listingNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            listingNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: listingNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for facilities
            facilitiesPlaceholderLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            facilitiesPlaceholderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            facilitiesPlaceholderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            facilitiesLabel.topAnchor.constraint(equalTo: facilitiesPlaceholderLabel.bottomAnchor, constant: 10),
            facilitiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            facilitiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for mapView
            mapView.topAnchor.constraint(equalTo: facilitiesLabel.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc private func favoriteButtonTapped() {
        // Handle favorite button tap logic here
        isFavorited.toggle()
        
        let heartImage = isFavorited ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
}
