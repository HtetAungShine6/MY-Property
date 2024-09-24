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
    
    lazy var listingDetailImage: UIImageView = {
        let listingDetailImage = UIImageView()
        listingDetailImage.contentMode = .scaleAspectFill
        listingDetailImage.clipsToBounds = true
        return listingDetailImage
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = false
        return mapView
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
        
        // Add subviews
        addSubview(listingDetailImage)
        addSubview(mapView)
        
        // Setup constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        listingDetailImage.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints for listing image
            listingDetailImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            listingDetailImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            listingDetailImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            listingDetailImage.heightAnchor.constraint(equalToConstant: 200),
            
            // Constraints for mapView
            mapView.topAnchor.constraint(equalTo: listingDetailImage.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
