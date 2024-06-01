//
//  HandleAlamofireResponse.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import Alamofire

protocol HandleAlamofireResponse {}

extension HandleAlamofireResponse {
    
    func handleAlamofireResponse<T: CodableInit>(decoder: T.Type, data: Data, urlrequest: URLRequest, response: HTTPURLResponse) throws -> T {
        if response.statusCode < 400 {
            do {
                let decodedResponse = try T(data: data)
                return decodedResponse
            } catch {
                return try decodeErrorResponse(decoder, data, response.statusCode, error)
            }
        } else {
            return try decodeErrorResponse(decoder, data, response.statusCode)
        }
    }
    
    private func decodeErrorResponse<T: CodableInit>(_ decoder: T.Type, _ response: Data, _ statusCode: Int, _ decodingError: Error? = nil) throws -> T {
        var responseData: Response
        do {
            responseData = try Response(data: response)
        } catch {
            return try handleFailedAlamofireResponse(decoder, nil, statusCode, decodingError)
        }
        return try handleFailedAlamofireResponse(decoder, responseData, statusCode)
    }
    
    private func handleFailedAlamofireResponse<T: CodableInit>(_ decoder: T.Type, _ errorResponse: Response?, _ statusCode: Int, _ decodingError: Error? = nil) throws -> T {
        guard let errorResponse = errorResponse else { throw CustomError.unknown(message: nil, statusCode: statusCode) }
        if statusCode < 400 {
            return try self.handleSuccessResponseError(errorResponse, with: decodingError)
        } else {
            throw CustomError.networkErrorWithStatusCode(statusCode, message: errorResponse.message ?? "Something went wrong")
        }
    }
}

// MARK: - Handle Errors

extension HandleAlamofireResponse {
    
    // MARK: Hanlde Success Response Errors
    
    private func handleSuccessResponseError<T: CodableInit>(_ errorResponse: Response, with decodingError: Error? = nil) throws -> T {
        if errorResponse.message != nil {
            throw CustomError.unknown(message: nil, statusCode: nil)
        }
        throw CustomError.decoding
    }
}
