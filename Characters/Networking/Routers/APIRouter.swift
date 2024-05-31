//
//  APIRouter.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Combine

enum APIRouter {}

// MARK: - API

extension APIRouter: API {
    
    static func getCharacters(by status: String?) -> AnyPublisher<CharactersResponse, Error> {
        CharactersRouter.getCharacters(status: status)
            .send(CharactersResponse.self)
    }
}
