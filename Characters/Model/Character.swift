//
//  Character.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation

struct Character: CodableInit {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
}

enum Status: String, CodableInit {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, CodableInit {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

// MARK: - Factory

extension Character {
    static func fake(id: Int = 1,
                     name: String = "Rick",
                     status: Status = .alive,
                     species: String = "Monster",
                     type: String = "Rick's Toxic Side",
                     gender: Gender = .male,
                     origin: Location = Location.fake(),
                     location: Location = Location.fake(),
                     image: String = "",
                     episode: [String] = ["E1", "E2"],
                     url: String = "") -> Character {
        Character(id: id,
                  name: name,
                  status: status,
                  species: species,
                  type: type,
                  gender: gender,
                  origin: origin,
                  location: location,
                  image: image,
                  episode: episode,
                  url: url)
    }
}
