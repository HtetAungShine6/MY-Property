//
//  AccountView.swift
//  MY Property
//
//  Created by Akito Daiki on 27/09/2024.
//

import UIKit
import SDWebImage

class AccountView: UIView {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let accountInfoLabel: UILabel = {
        let accountInfoLabel = UILabel()
        accountInfoLabel.font = UIFont(name: "Fredoka-Regular", size: 25)
        accountInfoLabel.textColor = .black
        accountInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return accountInfoLabel
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Fredoka-Regular", size: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Fredoka-Light", size: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = UIFont(name: "Fredoka-Regular", size: 18)
        emailLabel.textColor = .black
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "Fredoka-Light", size: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
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
        addSubview(accountInfoLabel)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        
        // Constraints for profileImageView
        setupConstraints()
        
        // Set circular profile image
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 250),
            profileImageView.heightAnchor.constraint(equalToConstant: 250),
            
            accountInfoLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            accountInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: accountInfoLabel.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    // Function to configure the view with user data
    func configure(with profileImageURL: String?, name: String?, email: String?) {
        
        accountInfoLabel.text = NSLocalizedString("account_info", comment: "Account Information")
        nameLabel.text = NSLocalizedString("name", comment: "Name")
        emailLabel.text = NSLocalizedString("email", comment: "Email")
        
        // Set the name and email if available
        nameTextField.text = name
        emailTextField.text = email
        
        // Load the profile image using SDWebImage
        if let imageURL = profileImageURL, let url = URL(string: imageURL) {
            profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_image"))
        } else {
            profileImageView.image = UIImage(named: "placeholder_image")
        }
    }
    
    // Function to retrieve input data
    func getFormData() -> (name: String?, email: String?) {
        let name = nameTextField.text
        let email = emailTextField.text
        return (name, email)
    }
}

