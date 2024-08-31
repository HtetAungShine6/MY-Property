//
//  GoogleService.swift
//  MY Property
//
//  Created by Akito Daiki on 20/08/2024.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth

class GoogleService {
    
    func signInWithGoogle() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { result, error in
            if let error = error {
                print("Error with: \(error.localizedDescription)")
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                guard let _ = authResult else {
                    print("Firebase Auth Error")
                    return
                }
                
                print("User Successfully Logged In")
                UserDefaults.standard.set(true, forKey: "AppState")
                if let window = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows.first {
                    
                    // Set the TabBarController as the root view controller
                    let tabBarController = UITabBarController()
                    
                    let homeVC = UINavigationController(rootViewController: HomeViewController())
                    homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
                    
                    let profileVC = UINavigationController(rootViewController: ProfileViewController())
                    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
                    
                    tabBarController.viewControllers = [homeVC, profileVC]
                    
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }
            }
        }
    }
    
    func signOutWithGoogle() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "AppState")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
