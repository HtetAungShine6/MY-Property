//
//  FavoritesViewController.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 24/9/2567 BE.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var favoriteListings: [FavoriteListing] = []
    private let firestore = Firestore.firestore()
    let favoriteListingsView = FavoriteView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
        fetchFavoriteListings()
    }
    
    override func loadView() {
        self.view = favoriteListingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "MY Favorite Listings"
    }
    
    // MARK: - CollectionView Setup
    func setupCollectionView() {
        favoriteListingsView.favoriteListingCollectionView.dataSource = self
        favoriteListingsView.favoriteListingCollectionView.delegate = self
        favoriteListingsView.favoriteListingCollectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavoriteListingCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteListings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let width = collectionView.frame.width - (padding * 2)
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteListingCell", for: indexPath) as! FavoriteCollectionViewCell
        let favoriteListing = favoriteListings[indexPath.item]
        cell.configure(with: favoriteListing)
        return cell
    }
    
    private func fetchFavoriteListings() {
        guard let _ = Auth.auth().currentUser else { return }
        let userEmail = KeychainManager.shared.keychain.get("email")
        
        firestore.collection("favorites")
            .whereField("userEmail", isEqualTo: userEmail ?? "no email found")
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching favorite listings: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self?.favoriteListings = documents.compactMap { (doc) -> FavoriteListing? in
                    let data = doc.data()
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let favoriteListing = try JSONDecoder().decode(FavoriteListing.self, from: jsonData)
                        return favoriteListing
                    } catch {
                        print("Error decoding favorite listing: \(error)")
                        return nil
                    }
                }
                
                // Reload collection view after fetching data
                self?.favoriteListingsView.favoriteListingCollectionView.reloadData()
            }
    }

}
