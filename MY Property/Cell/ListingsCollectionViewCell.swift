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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCell() {
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 2, height: 4)
        contentView.layer.masksToBounds = true
                                                        
        
        contentView.addSubview(listingImage)
        contentView.addSubview(listingName)
        
        listingImage.translatesAutoresizingMaskIntoConstraints = false
        listingName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            listingImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listingImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listingImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            
        
            
            listingName.topAnchor.constraint(equalTo: listingImage.bottomAnchor, constant: 8),
            listingName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            listingName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(with listing: Listing) {
        listingName.text = listing.listingName
        
        if let partialImageUrl = listing.listingHero?.asset._ref {
            if let imageURL = buildImageURL(from: partialImageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.listingImage.image = image
                            print("IMAGE: \(image)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.listingImage.image = UIImage(named: "placeholder_image")
                        }
                    }
                }
            } else {
                listingImage.image = UIImage(named: "placeholder_image")
            }
        } else {
            listingImage.image = UIImage(named: "placeholder_image")
        }
    }
}
