//
//  Constants.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

enum Constants {
    
    // MARK: Networking Configuration
    
    enum NetworkingConfigs {
        static let acceptHeaderKey = "Accept"
        static let acceptHeaderValue = "application/json"
        static let pageParameterKey = "page"
        static let baseURL = "https://rickandmortyapi.com/api/"
    }
    
    // MARK: Character statuses
    
    static let characterStatuses = ["alive", "dead", "unknown"]
}
