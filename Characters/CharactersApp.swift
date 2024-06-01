//
//  CharactersApp.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import SwiftUI

@main
struct CharactersApp: App {
    
    // MARK: Properties
    
    var api: API.Type {
        var isTesting = false
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            isTesting = true
        }
        #endif
        return isTesting ? MockAPI.self : APIRouter.self
    }
    
    // MARK: Body
    
    var body: some Scene {
        WindowGroup {
            CharactersListViewControllerRepresentable(api: self.api)
                .ignoresSafeArea()
        }
    }
}
