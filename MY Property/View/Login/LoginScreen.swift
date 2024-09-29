//
//  LoginScreen.swift
//  MY Property
//
//  Created by Akito Daiki on 26/08/2024.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginScreen: UIView {
    
    private let sanityService = SanityService()
    private let googleService = GoogleService()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let logoImage = UIImage(named: "my-logo") {
            imageView.image = logoImage
        }
        return imageView
    }()
    
    private let signInButton: UIButton = {
        let signInButton = UIButton(type: .system)
        if let backgroundImage = UIImage(named: "continueWithGoogle") {
            signInButton.setBackgroundImage(backgroundImage, for: .normal)
        }
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        return signInButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    // Triggers on Storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        // Add logo and sign-in button to the stack view
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(signInButton)
        
        // Add stack view to the main view
        addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Center the stack view in the middle of the screen
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Set logo image size
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Set sign-in button size
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func signInButtonTapped() {
        googleService.signInWithGoogle()
        googleService.printKeychainData()
    }
}
