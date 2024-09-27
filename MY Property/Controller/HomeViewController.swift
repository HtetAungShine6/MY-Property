//
//  HomeViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 25/08/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private let googleService = GoogleService()
    private let sanityService = SanityService()
    
    private var properties: [Property] = []
    private var filteredProperties: [Property] = []
    
    private var listings: [Listing] = []
    private var filteredListings: [Listing] = []
    
    private var isSearching = false
    
    let homeView = HomeView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white

        setupCollectionView()
    }
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        GetProperty()
    }
    
    func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Get the user's display name (fall back to empty string if nil)
        let userName = FirebaseManager.shared.auth.currentUser?.displayName ?? ""
        // Use NSLocalizedString to get the localized welcome message
        let welcomeMessage = String(format: NSLocalizedString("welcome_message", comment: "Welcome message with user's name"), userName)
        
        let userNameLabel = UILabel()
        userNameLabel.text = welcomeMessage
        userNameLabel.font = UIFont(name: "Fredoka-Light", size: 18)
        userNameLabel.textColor = .black
        
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 15
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        if let photoURL = Auth.auth().currentUser?.photoURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: photoURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        profileImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        profileImageView.image = UIImage(named: "placeholder_image")
                    }
                }
            }
        } else {
            profileImageView.image = UIImage(named: "placeholder_image")
        }
        
        let profileStackView = UIStackView(arrangedSubviews: [profileImageView, userNameLabel])
        profileStackView.axis = .horizontal
        profileStackView.spacing = 8
        profileStackView.alignment = .center
        
        let profileBarItem = UIBarButtonItem(customView: profileStackView)
        
        navigationItem.leftBarButtonItem = profileBarItem
    }
    
    // MARK: - CollectionView Setup
    func setupCollectionView() {
        homeView.propertyCollectionView.dataSource = self
        homeView.propertyCollectionView.delegate = self
        homeView.propertyCollectionView.register(PropertyCollectionViewCell.self, forCellWithReuseIdentifier: "PropertyCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredProperties.count : properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyCell", for: indexPath) as! PropertyCollectionViewCell
        let property = isSearching ? filteredProperties[indexPath.item] : properties[indexPath.item]
        cell.configure(with: property)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let width = collectionView.frame.width - (padding * 2)
        let height = collectionView.frame.height / 2.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProperty: Property
        if isSearching {
            selectedProperty = filteredProperties[indexPath.item]
        } else {
            selectedProperty = properties[indexPath.item]
        }
        
        print("Selected Property: \(selectedProperty.title)")
        GetListingByPropertyId(propertyId: selectedProperty._id)
        
        // Instantiate the target view controller
        let propertyDetailViewController = ListingsViewController()
        
        // Pass the selected property ID to the next view controller
        propertyDetailViewController.propertyId = selectedProperty._id
        
        // Pass latitude and longitude, and facilities to ListingsViewController
        propertyDetailViewController.propertyLat = selectedProperty.latitude
        propertyDetailViewController.propertyLong = selectedProperty.longitude
        propertyDetailViewController.facilities = selectedProperty.facilities
        
        // Push the new view controller onto the navigation stack
        navigationController?.pushViewController(propertyDetailViewController, animated: true)
    }
    
    
    // MARK: - Search Bar Delegate
    func setupSearchBar() {
        homeView.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProperties = searchText.isEmpty ? properties : properties.filter { $0.title.range(of: searchText, options: .caseInsensitive) != nil }
        isSearching = !filteredProperties.isEmpty
        homeView.propertyCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filteredProperties.removeAll()
        homeView.propertyCollectionView.reloadData()
    }
}

extension HomeViewController {
    private func GetProperty() {
        sanityService.fetchAllProperties { result in
            switch result {
            case .success(let properties):
                self.properties = properties
                DispatchQueue.main.async {
                    self.homeView.propertyCollectionView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch properties: \(error.localizedDescription)")
            }
        }
    }
    
    private func GetListingByPropertyId(propertyId: String) {
        sanityService.fetchListingsByPropertyId(byPropertyId: propertyId) { result in
            switch result {
            case .success(let listings):
                self.listings = listings
                DispatchQueue.main.async {
                    print("Listings for \(propertyId):")
                    for listing in listings {
                        print(listing.listingName)
                    }
                }
            case .failure(let error):
                print("Failed to fetch listings by property ID: \(error.localizedDescription)")
            }
        }
    }
}
