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
    
    case getCharacters
    
    // MARK: Properties
    
    static let charactersPath = "character"
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
        case .getCharacters:
            return nil
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
