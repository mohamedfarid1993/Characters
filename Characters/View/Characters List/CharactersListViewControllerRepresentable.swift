//
//  CharactersListViewControllerRepresentable.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import SwiftUI

struct CharactersListViewControllerRepresentable: UIViewControllerRepresentable {
    
    var api: API.Type
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let charactersListViewController = CharactersListViewController(api: self.api)
        let navigationController = UINavigationController(rootViewController: charactersListViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
