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
    
    static func getCharacters() -> AnyPublisher<Response, Error> {
        Future<Response, Error> { promise in
            promise(.success(Response.fake()))
        }.eraseToAnyPublisher()
    }
}
