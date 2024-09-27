//
//  ListingDetailViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 24/09/2024.
//

import UIKit
import SDWebImage
import MapKit
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

class ListingDetailViewController: UIViewController {
    
    var listing: Listing?
    var propertyLat: Double?
    var propertyLong: Double?
    var facilities: [Property.Facility]?
    let firestore = Firestore.firestore()
    var shouldSetFavorite: Bool = false
    var favoriteDocumentId: String?
    
    let listingDetailView = ListingDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupMap()
        checkIfFavorite()
        listingDetailView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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
            
            let statusText = "Status - \(listing.statusActive)"
            let attributedStatus = NSMutableAttributedString(string: statusText)
            if let activeRange = statusText.range(of: listing.statusActive) {
                let nsRange = NSRange(activeRange, in: statusText)
                attributedStatus.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: nsRange)
            }
            
            if let facilities = facilities {
                let facilityTypes = facilities.map { $0.facilityType }.joined(separator: ", ")
                listingDetailView.facilitiesLabel.text = facilityTypes
            } else {
                listingDetailView.facilitiesLabel.text = "No facilities available"
            }
            
            listingDetailView.listingNameLabel.text = listing.listingName
            listingDetailView.descriptionLabel.text = listing.description
            listingDetailView.contractLabel.text = "Starting from \(listing.minimumContractInMonth) months"
            listingDetailView.furnitureLabel.text = listing.furniture
            
            listingDetailView.contractPlaceholderLabel.text = "Contract"
            listingDetailView.facilitiesPlaceholderLabel.text = "Facilities"
            listingDetailView.locationLabel.text = "Location"
            listingDetailView.furniturePlaceholderLabel.text = "Furniture Type"
            listingDetailView.statusPlaceholderLabel.attributedText = attributedStatus
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
    
    @objc private func favoriteButtonTapped() {
        // Toggle favorite state and update the button appearance
        if shouldSetFavorite {
            // If the listing is already favorited, can remove it from Firestore by clicking it
            removeFavoriteListingFromFirestore()
        } else {
            // If the listing is not yet favorited, cab save it to Firestore by clicking it
            saveFavoriteListingToFirestore()
        }
    }
    
    private func saveFavoriteListingToFirestore() {
        guard let _ = Auth.auth().currentUser,
              let listing = listing else { return }
        
        let favoriteData: [String: Any] = [
            "userEmail": KeychainManager.shared.keychain.get("email") ?? "no email found",
            "firebaseId": KeychainManager.shared.keychain.get("fId") ?? "no id found",
            "listingName": listing.listingName,
            "listingPrice": listing.price,
            "listingImage": buildImageURL(from: listing.listingHero?.asset._ref ?? "no image")?.absoluteString ?? "no_image"
        ]
        
        firestore.collection("favorites").addDocument(data: favoriteData) { [weak self] error in
            if let error = error {
                print("Error saving favorite: \(error)")
            } else {
                self?.shouldSetFavorite = true
                self?.updateFavoriteButton()
//                self?.listingDetailView.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                print("Favorite saved successfully!")
            }
        }
    }
    
    private func removeFavoriteListingFromFirestore() {
        guard let documentId = favoriteDocumentId else { return }
        
        firestore.collection("favorites").document(documentId).delete { [weak self] error in
            if let error = error {
                print("Error removing favorite: \(error)")
            } else {
                self?.shouldSetFavorite = false
                self?.updateFavoriteButton()
                print("Favorite removed successfully!")
            }
        }
    }
    
    private func updateFavoriteButton() {
        // Update the button appearance based on the `shouldSetFavorite` state
        let imageName = shouldSetFavorite ? "heart.fill" : "heart"
        listingDetailView.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func checkIfFavorite() {
        guard let user = KeychainManager.shared.keychain.get("fId"), let listing = listing else { return }
        
        firestore.collection("favorites")
            .whereField("firebaseId", isEqualTo: user)
            .whereField("listingName", isEqualTo: listing.listingName)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error checking favorite status: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents, let document = documents.first else {
                    self?.shouldSetFavorite = false
                    self?.listingDetailView.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    return
                }
                
                self?.shouldSetFavorite = true
                self?.favoriteDocumentId = document.documentID
                self?.listingDetailView.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
    }
}
