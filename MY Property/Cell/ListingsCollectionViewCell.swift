//
//  ListingsCollectionViewCell.swift
//  MY listing
//
//  Created by Lynn Thit Nyi Nyi on 2/9/2567 BE.
//

import UIKit

class ListingsCollectionViewCell: UICollectionViewCell {
    
    lazy var listingImage: UIImageView = {
        let listingImage = UIImageView()
        listingImage.contentMode = .scaleAspectFill
        listingImage.clipsToBounds = true
        return listingImage
    }()
    
    lazy var listingName: UILabel = {
        let listingName = UILabel()
        listingName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        listingName.textColor = .black
        return listingName
    }()
    
    lazy var listingPriceRange: UILabel = {
        let listingMinPrice = UILabel()
        listingMinPrice.font = UIFont.systemFont(ofSize: 16, weight: .light)
        listingMinPrice.textColor = .black
        return listingMinPrice
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCell() {
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 2, height: 4)
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(listingImage)
        contentView.addSubview(listingName)
        contentView.addSubview(listingPriceRange)
        
        listingImage.translatesAutoresizingMaskIntoConstraints = false
        listingName.translatesAutoresizingMaskIntoConstraints = false
        listingPriceRange.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            listingImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listingImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listingImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            listingName.topAnchor.constraint(equalTo: listingImage.bottomAnchor, constant: 16),
            listingName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            listingName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            listingPriceRange.topAnchor.constraint(equalTo: listingName.bottomAnchor, constant: 8),
            listingPriceRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            listingPriceRange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset the image to prevent displaying the wrong image
        listingImage.image = UIImage(named: "placeholder_image")
        listingName.text = nil
        listingPriceRange.text = "0"
    }
    
    func configure(with listing: Listing) {
        listingName.text = listing.listingName
        
        if let maxPrice = listing.maxPrice, maxPrice > 0 {
            listingPriceRange.text = "\(Int(listing.minPrice?.rounded() ?? 0)) THB  -  \(Int(maxPrice.rounded())) THB"
        } else {
            listingPriceRange.text = "\(Int(listing.minPrice?.rounded() ?? 0)) THB"
        }
        
        if let partialImageUrl = listing.listingHero?.asset._ref {
            if let imageURL = buildImageURL(from: partialImageUrl) {
                listingImage.sd_setImage(
                    with: imageURL,
                    placeholderImage: UIImage(named: "placeholder_image"),
                    options: .continueInBackground,
                    completed: nil
                )
            } else {
                listingImage.image = UIImage(named: "placeholder_image")
            }
        } else {
            listingImage.image = UIImage(named: "placeholder_image")
        }
    }
}
