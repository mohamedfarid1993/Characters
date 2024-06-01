//
//  CharactersListViewControllerRepresentable.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import SwiftUI

struct CharactersListViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let charactersListViewController = CharactersListViewController()
        let navigationController = UINavigationController(rootViewController: charactersListViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
