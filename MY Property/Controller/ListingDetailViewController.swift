//
//  ListingDetailViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 24/09/2024.
//

import UIKit
import SDWebImage
import MapKit

class ListingDetailViewController: UIViewController {

    var listing: Listing?
    var propertyLat: Double?
    var propertyLong: Double?
    
    let listingDetailView = ListingDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupMap()
    }
    
    override func loadView() {
        self.view = listingDetailView
    }
    
    private func setupUI() {
        if let listing = listing {
            if let partialImageUrl = listing.listingHero?.asset._ref {
                if let imageURL = buildImageURL(from: partialImageUrl) {
                    listingDetailView.listingDetailImage.sd_setImage(
                        with: imageURL,
                        placeholderImage: UIImage(named: "placeholder_image"),
                        options: .continueInBackground,
                        completed: nil
                    )
                } else {
                    listingDetailView.listingDetailImage.image = UIImage(named: "placeholder_image")
                }
            } else {
                listingDetailView.listingDetailImage.image = UIImage(named: "placeholder_image")
            }
        }
    }
    
    private func setupMap() {
        guard let latitude = propertyLat, let longitude = propertyLong else {
            print("Latitude and longitude not available")
            return
        }
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        listingDetailView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = listing?.listingName
        listingDetailView.mapView.addAnnotation(annotation)
    }
}
