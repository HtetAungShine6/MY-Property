//
//  AccountView.swift
//  MY Property
//
//  Created by Akito Daiki on 27/09/2024.
//

import UIKit
import SDWebImage

class AccountView: UIView {
    
    // UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // Setup UI
    private func setupView() {
        backgroundColor = .white
        
        // Add subviews
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        
        // Constraints for profileImageView
        setupConstraints()
        
        // Set circular profile image
        profileImageView.layer.cornerRadius = 50 // Half of the width/height for circular effect
        profileImageView.layer.masksToBounds = true // Ensure the image is clipped to the bounds
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    // Function to configure the view with user data
    func configure(with profileImageURL: String?, name: String, email: String) {
        // Set the name and email in the desired format
        nameLabel.text = "Name - \(name)"
        emailLabel.text = "Email - \(email)"
        
        // Load the profile image using SDWebImage
        if let imageURL = profileImageURL, let url = URL(string: imageURL) {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_image"))
        } else {
            profileImageView.image = UIImage(named: "placeholder_image") // Fallback image
        }
    }
}
