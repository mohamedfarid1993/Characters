//
//  Location.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

struct Location: CodableInit {
    let name: String
    let url: String
}

// MARK: - Factory

extension Location {
    static func fake(name: String = "Earth", url: String = "") -> Location {
        Location(name: name, url: url)
    }
}
