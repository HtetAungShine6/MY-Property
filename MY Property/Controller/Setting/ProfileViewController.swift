//
//  ProfileViewController.swift
//  MY Property
//
//  Created by Akito Daiki on 30/08/2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let googleService = GoogleService()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("sign_out", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Fredoka-Regular", size: 16)
        return button
    }()
    
    let tableData: [String] = {
        return [
            NSLocalizedString("account_cell", comment: "Account"),
            NSLocalizedString("favorite_cell", comment: "Favorites")
        ]
    }()
    
    let upcomingFeaturesData: [String] = [
        NSLocalizedString("recent", comment: "Recent"),
        NSLocalizedString("appearance", comment: "Appearance"),
        NSLocalizedString("restricted", comment: "Restricted"),
        NSLocalizedString("notifications", comment: "Notifications"),
        NSLocalizedString("report_a_problem", comment: "Report a problem")
    ]
    
    private let featuresNowLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("features_available_now", comment: "Features Available Now")
        label.font = UIFont(name: "Fredoka-Regular", size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let upcomingFeaturesLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("upcoming_features", comment: "Upcoming Features")
        label.font = UIFont(name: "Fredoka-Regular", size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let upcomingFeaturesTableView = UITableView(frame: .zero, style: .plain) // New TableView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationTitle()
        setupScrollView()
        setupTableView()
        setupUpcomingFeaturesTableView()
        setupSignOutButton()
        setupLayout()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
    }
    
    func setupUpcomingFeaturesTableView() {
        upcomingFeaturesTableView.delegate = self
        upcomingFeaturesTableView.dataSource = self
        upcomingFeaturesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "upcomingFeaturesCell")
        upcomingFeaturesTableView.translatesAutoresizingMaskIntoConstraints = false
        upcomingFeaturesTableView.isScrollEnabled = false
    }
    
    func setupNavigationTitle() {
        self.title = NSLocalizedString("Settings", comment: "Settings")
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Fredoka-Regular", size: 34)!,
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    func setupSignOutButton() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
    func setupLayout() {
        // Add the labels, tableView, upcomingFeaturesTableView, and signOutButton to the content view inside the scroll view
        contentView.addSubview(featuresNowLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(upcomingFeaturesLabel)
        contentView.addSubview(upcomingFeaturesTableView)
        contentView.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            // Features Now Label
            featuresNowLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            featuresNowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // First TableView (Features available now)
            tableView.topAnchor.constraint(equalTo: featuresNowLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 100),
            
            // Upcoming Features Label
            upcomingFeaturesLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
            upcomingFeaturesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Upcoming Features TableView
            upcomingFeaturesTableView.topAnchor.constraint(equalTo: upcomingFeaturesLabel.bottomAnchor, constant: 5),
            upcomingFeaturesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upcomingFeaturesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upcomingFeaturesTableView.heightAnchor.constraint(equalToConstant: 290),
            
            // Sign Out Button
            signOutButton.topAnchor.constraint(equalTo: upcomingFeaturesTableView.bottomAnchor, constant: 20),
            signOutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signOutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func signOut() {
        let alertController = UIAlertController(title: NSLocalizedString("sign_out", comment: "Sign Out"), message: NSLocalizedString("sign_out_confirmation", comment: "Are you sure you want to sign out?"), preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: NSLocalizedString("yes", comment: "Yes"), style: .destructive) { _ in
            self.googleService.signOutWithGoogle()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("no", comment: "No"), style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return tableData.count
        } else {
            return upcomingFeaturesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = tableData[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = UIFont(name: "Fredoka-Light", size: 16)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingFeaturesCell", for: indexPath)
            
            // Create a label and a lock icon for each cell
            let featureLabel = UILabel()
            featureLabel.text = upcomingFeaturesData[indexPath.row]
            featureLabel.font = UIFont(name: "Fredoka-Light", size: 16)
            featureLabel.textColor = .black
            
            let lockIcon = UIImageView(image: UIImage(systemName: "lock.fill"))
            lockIcon.tintColor = .gray
            
            cell.contentView.addSubview(featureLabel)
            cell.contentView.addSubview(lockIcon)
            
            // Disable autoresizing masks and use constraints
            featureLabel.translatesAutoresizingMaskIntoConstraints = false
            lockIcon.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                featureLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                featureLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                
                lockIcon.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                lockIcon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == self.tableView {
            switch indexPath.row {
            case 0:
                let accountVC = AccountViewController()
                navigationController?.pushViewController(accountVC, animated: true)
            case 1:
                let favoritesVC = FavoritesViewController()
                navigationController?.pushViewController(favoritesVC, animated: true)
            default:
                break
            }
        }
    }
}
