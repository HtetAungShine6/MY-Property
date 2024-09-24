//
//  ListingsViewController.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 2/9/2567 BE.
//

import UIKit

class ListingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var propertyId = ""
    
    var listings:[Listing] = []
    private var filteredListings: [Listing] = []
    
    let listingsHomeView = ListingsHomeView()
    private let sanityService = SanityService()
    
    var propertyLat: Double?
    var propertyLong: Double?

    private var isSearching = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
    }
    
    override func loadView() {
        self.view = listingsHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        getListings(propertyId: propertyId)

        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "MY Listings"
    }
    
    // MARK: - CollectionView Setup
    func setupCollectionView() {
        listingsHomeView.listingCollectionView.dataSource = self
        listingsHomeView.listingCollectionView.delegate = self
        listingsHomeView.listingCollectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: "ListingCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredListings.count : listings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let width = collectionView.frame.width - (padding * 2)
        let height = collectionView.frame.height / 2.5
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as! ListingsCollectionViewCell
        let listing = isSearching ? filteredListings[indexPath.item] : listings[indexPath.item]
        cell.configure(with: listing)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedListing: Listing
        if isSearching {
            selectedListing = filteredListings[indexPath.item]
        } else {
            selectedListing = listings[indexPath.item]
        }
        
        // Navigate to ListingDetailViewController
        let listingDetailViewController = ListingDetailViewController()
        
        // Pass the selected listing
        listingDetailViewController.listing = selectedListing
        
        // Pass latitude and longitude
        listingDetailViewController.propertyLat = self.propertyLat
        listingDetailViewController.propertyLong = self.propertyLong
        
        // Push the new view controller onto the navigation stack
        navigationController?.pushViewController(listingDetailViewController, animated: true)
    }
    
    // MARK: - Search Bar Delegate
    func setupSearchBar() {
        listingsHomeView.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredListings = searchText.isEmpty ? listings : listings.filter { $0.listingName.range(of: searchText, options: .caseInsensitive) != nil }
        isSearching = !filteredListings.isEmpty
        listingsHomeView.listingCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filteredListings.removeAll()
        listingsHomeView.listingCollectionView.reloadData()
    }

    func getListings(propertyId: String) {
        
        sanityService.fetchListingsByPropertyId(byPropertyId: propertyId) { result in
            switch result {
            case .success(let listings):
                self.listings = listings
                DispatchQueue.main.async {
                    print("Listings for \(propertyId):")
                    for listing in listings {
                        print(listing.listingName, String(describing: listing.minPrice ?? 0), String(describing: listing.maxPrice ?? 0))
                    }
                    self.listingsHomeView.listingCollectionView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch listings by property ID: \(error.localizedDescription)")
            }
        }
    }
}
