//
//  API.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Combine

protocol API {
    static func getCharacters(by status: String?) -> AnyPublisher<CharactersResponse, Error>
}
