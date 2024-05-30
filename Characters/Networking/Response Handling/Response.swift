//
//  Response.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

struct Response: CodableInit {
    
    // MARK: Properties
    
    var message: String?
    var errors: [String: [String]]?
}

// MARK: - Factory

extension Response {
    static func fake(
        message: String? = "The email is not valid",
        errors: [String: [String]]? = nil
    ) -> Response {
        Response(message: message, errors: errors)
    }
}
