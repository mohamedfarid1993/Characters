//
//  Info.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

struct Info: CodableInit {

    // MARK: Properties

    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Factory

extension Info {
    static func fake(count: Int = 1, pages: Int = 1, next: String? = "", prev: String? = "") -> Info {
        Info(count: count, pages: pages, next: next, prev: prev)
    }
}
