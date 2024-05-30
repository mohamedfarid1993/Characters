//
//  RoutersTests.swift
//  CharactersTests
//
//  Created by Mohamed Farid on 30/05/2024.
//

@testable import Characters
import XCTest

// MARK: - Characters Router Tests

class RoutersTests: XCTestCase {
    
    // MARK: Get Characters Request Test
    
    func testGetCharactersRequest() {
        
        let getCharactersRequest = CharactersRouter.getCharacters
        XCTAssertEqual(getCharactersRequest.path, CharactersRouter.charactersPath)
        XCTAssertEqual(getCharactersRequest.method, .get)
        XCTAssertNil(getCharactersRequest.parameters)
    }
}
