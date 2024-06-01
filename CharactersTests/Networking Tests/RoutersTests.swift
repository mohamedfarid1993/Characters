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
        let status = "Alive"
        let page = 2
        let getCharactersRequest = CharactersRouter.getCharacters(status: status, page: page)
        
        XCTAssertEqual(getCharactersRequest.path, CharactersRouter.charactersPath)
        XCTAssertEqual(getCharactersRequest.method, .get)
        XCTAssertEqual(status, getCharactersRequest.parameters?[CharactersRouter.statusParameterKey] as? String)
        XCTAssertEqual(page, getCharactersRequest.parameters?[CharactersRouter.pageParameterKey] as? Int)
    }
}
