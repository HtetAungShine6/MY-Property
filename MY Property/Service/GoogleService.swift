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
                
                DispatchQueue.main.async {
                    if let windowScene = UIApplication.shared.connectedScenes
                        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.updateRootViewController()
                    }
                }
            }
        }
    }
    
    func signOutWithGoogle() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "AppState")
            KeychainManager.shared.keychain.delete("userEmail")
            KeychainManager.shared.keychain.delete("fId")
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.updateRootViewController()
                }
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func printKeychainData() {
        if let userEmail = KeychainManager.shared.keychain.get("userEmail") {
            print("User Email: \(userEmail)")
        } else {
            print("No email found in Keychain.")
        }
        
        if let userId = KeychainManager.shared.keychain.get("fId") {
            print("Firebase User ID: \(userId)")
        } else {
            print("No Firebase User ID found in Keychain.")
        }
    }
    
}
