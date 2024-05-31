//
//  CharactersRouter.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import Alamofire

enum CharactersRouter: URLRequestBuilder {
        
    // MARK: - APIs
    
    case getCharacters(status: String?)
    
    // MARK: Properties
    
    static let charactersPath = "character"
    static let statusParameterKey = "status"
}

extension CharactersRouter {
        
    var path: String {
        switch self {
        case .getCharacters:
            return CharactersRouter.charactersPath
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCharacters(let status):
            guard let status = status else { return nil }
            return [CharactersRouter.statusParameterKey: status]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
