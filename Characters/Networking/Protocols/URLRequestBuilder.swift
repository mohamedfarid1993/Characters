//
//  URLRequestBuilder.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    var mainURL: String { get }
    var parameters: Parameters? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var url: URL { get }
    var urlRequest: URLRequest { get }
    var encoding: ParameterEncoding { get }
}

extension URLRequestBuilder {
    
    var headers: [String: String] {
        var headers: [String: String] = [:]
        
        headers[Constants.NetworkingConfigs.acceptHeaderKey] = Constants.NetworkingConfigs.acceptHeaderValue
        
        return headers
    }
    
    var mainURL: String {
        Constants.NetworkingConfigs.baseURL
    }
    
    var url: URL {
        var url = URL(string: mainURL)!
        url.appendPathComponent(path)
        return url
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        return urlRequest
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        try encoding.encode(urlRequest, with: parameters)
    }
}
