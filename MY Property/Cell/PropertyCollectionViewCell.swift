//
//  PropertyCollectionViewCell.swift
//  MY Property
//
//  Created by Akito Daiki on 29/08/2024.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    
    lazy var propertyImage: UIImageView = {
        let propertyImage = UIImageView()
        propertyImage.contentMode = .scaleAspectFill
        propertyImage.clipsToBounds = true
        return propertyImage
    }()
    
    lazy var propertyName: UILabel = {
        let propertyName = UILabel()
        propertyName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        propertyName.textColor = .black
        return propertyName
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
                                                        
        
        contentView.addSubview(propertyImage)
        contentView.addSubview(propertyName)
        
        propertyImage.translatesAutoresizingMaskIntoConstraints = false
        propertyName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            propertyImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            propertyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            propertyImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            propertyImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            propertyName.topAnchor.constraint(equalTo: propertyImage.bottomAnchor, constant: 8),
            propertyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            propertyName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(with property: Property) {
        propertyName.text = property.title
        
        if let partialImageUrl = property.propertyHero.asset._ref {
            if let imageURL = buildImageURL(from: partialImageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.propertyImage.image = image
                            print("IMAGE: \(image)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.propertyImage.image = UIImage(named: "placeholder_image")
                        }
                    }
                }
            } else {
                propertyImage.image = UIImage(named: "placeholder_image")
            }
        } else {
            propertyImage.image = UIImage(named: "placeholder_image")
        }
    }
}
