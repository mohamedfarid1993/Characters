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
    
    case getCharacters(status: String?, page: Int)
    
    // MARK: Properties
    
    static let charactersPath = "character"
    static let statusParameterKey = "status"
    static let pageParameterKey = "page"
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
        case .getCharacters(let status, let page):
            guard let status = status else { return [CharactersRouter.pageParameterKey: page] }
            return [
                CharactersRouter.statusParameterKey: status,
                CharactersRouter.pageParameterKey: page
            ]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
