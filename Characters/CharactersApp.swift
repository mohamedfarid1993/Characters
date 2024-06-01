//
//  CharactersApp.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import SwiftUI

@main
struct CharactersApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListViewControllerRepresentable()
                .ignoresSafeArea()
        }
    }
}
