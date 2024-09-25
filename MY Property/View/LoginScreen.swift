//
//  LoginScreen.swift
//  MY Property
//
//  Created by Akito Daiki on 26/08/2024.
//

import Foundation
import UIKit

class LoginScreen: UIView {
    
    private let sanityService = SanityService()
    private let googleService = GoogleService()
    
    private let signInButton: UIButton = {
        let signInButton = UIButton(type: .system)
        if let backgroundImage = UIImage(named: "continueWithGoogle") {
            signInButton.setBackgroundImage(backgroundImage, for: .normal)
        }
        return signInButton
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
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(signInButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func signInButtonTapped() {
        googleService.signInWithGoogle()
        googleService.printKeychainData()
    }
}
