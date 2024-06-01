//
//  APIRequestHandler.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import Alamofire
import Combine

/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamofireResponse {}

// MARK: - Request Methods

extension APIRequestHandler where Self: URLRequestBuilder {
    
    func send<T: CodableInit>(_ decoder: T.Type) -> AnyPublisher<T, Error> {
        NetworkManager.session.request(self)
            .publishData()
            .tryMap({ response in
                switch response.result {
                case .failure:
                    throw CustomError.networkConnection
                case .success(let value):
                    guard let httpURLResponse = response.response else {
                        throw CustomError.unknown(message: nil, statusCode: nil)
                    }
                    return try handleAlamofireResponse(
                        decoder: decoder,
                        data: value,
                        urlrequest: self.urlRequest,
                        response: httpURLResponse
                    )
                }
            })
            .eraseToAnyPublisher()
    }
}
