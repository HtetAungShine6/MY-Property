//
//  LanguageViewController.swift
//  MY Property
//
//  Created by Lynn Thit Nyi Nyi on 24/9/2567 BE.
//

import UIKit

class LanguageViewController: UIViewController {
    
    let languageView = LanguageView()
    
    override func loadView() {
        self.view = languageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Load the previously selected language
        let selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "English"
        print("Selected Language: \(selectedLanguage)")
        
        languageView.onLanguageSelected = { selectedLanguage in
            // Save the selected language
            UserDefaults.standard.setValue(selectedLanguage, forKey: "selectedLanguage")
            print("Language selected: \(selectedLanguage)")
        }
    }
}

