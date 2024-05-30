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
    let results: [Character]
}

// MARK: - Factory

extension CharactersResponse {
    static func fake(info: Info = Info.fake(), results: [Character] = [Character.fake(), Character.fake()]) -> CharactersResponse {
        CharactersResponse(info: info, results: results)
    }
}
