//
//  MockAPI.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Combine

enum MockAPI { }

// MARK: - API

extension MockAPI: API {
    
    static func getCharacters(by status: String?, in page: Int) -> AnyPublisher<CharactersResponse, Error> {
        Future<CharactersResponse, Error> { promise in
            promise(.success(CharactersResponse.fake()))
        }.eraseToAnyPublisher()
    }
}
