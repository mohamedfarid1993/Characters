//
//  CustomError.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

public enum CustomError: LocalizedError {
    case decoding
    case networkErrorWithStatusCode(_ statusCode: Int, message: String)
    case offline
    case unknown(message: String?, statusCode: Int?)
    case networkConnection
    
    public var errorDescription: String? {
        switch self {
        case .decoding:
            return "Sorry, unexpected error occured. will fix this so soon"
        case .offline:
            return "Please connect to the internet"
        case .unknown(let message, _):
            return message ?? "Sorry, unknown error occured.\nPlease try again in a while"
        case .networkConnection:
            return "Please check your internet connection"
        case .networkErrorWithStatusCode(_, let message):
            return message
        }
    }
    
    public var statusCode: Int? {
        switch self {
        case .networkErrorWithStatusCode(let statusCode, _):
            return statusCode
        case .unknown(_, let statusCode):
            return statusCode
        default:
            return nil
        }
    }
}
