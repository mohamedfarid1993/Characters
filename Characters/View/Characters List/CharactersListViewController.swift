//
//  CharactersListViewController.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = CharactersListViewModel()
    
    // MARK: - Life Cycle View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
}

// MARK: - Setup Navigation Appearance

extension CharactersListViewController {
    private func setupNavigationBar() {
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.Colors.titlesDarkPurple]
        standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.Colors.titlesDarkPurple]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.clear
        standardAppearance.shadowImage = UIImage()
        standardAppearance.shadowColor = nil
        
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}
