//
//  CharactersResponse.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

struct CharactersResponse: CodableInit {
    
    // MARK: Properties
    
    let info: Info
    let characters: [Character]
}

// MARK: - Codable

extension CharactersResponse {
    
    private enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

// MARK: - Factory

extension CharactersResponse {
    static func fake(info: Info = Info.fake(), characters: [Character] = [Character.fake(), Character.fake()]) -> CharactersResponse {
        CharactersResponse(info: info, characters: characters)
    }
}
