//
//  ViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let sanityService = SanityService()
    private let googleService = GoogleService()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        //        GetProperty()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(signInButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func signInButtonTapped() {
        googleService.signInWithGoogle()
    }
}

extension ViewController {
    private func GetProperty() {
        sanityService.fetchAllProperties { result in
            switch result {
            case .success(let properties):
                for property in properties {
                    print("Property: \(property)")
                }
            case .failure(let error):
                print("Failed to fetch properties: \(error.localizedDescription)")
            }
        }
    }
}
