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
    
    let listingsHomeView = ListingsHomeView()
    private let sanityService = SanityService()

    
    override func loadView() {
        self.view = listingsHomeView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupCollectionView()
        
        getListings(propertyId: propertyId)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        
        getListings(propertyId: propertyId)

        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "MY Property"
    }
    
    // MARK: - CollectionView Setup
    func setupCollectionView() {
        listingsHomeView.listingCollectionView.dataSource = self
        listingsHomeView.listingCollectionView.delegate = self
        listingsHomeView.listingCollectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: "ListingCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let width = collectionView.frame.width - (padding * 2)
        let height = collectionView.frame.height / 2.5
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath) as! ListingsCollectionViewCell
        let listing = listings[indexPath.item]
        cell.configure(with: listing)
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
