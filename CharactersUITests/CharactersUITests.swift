//
//  CharactersUITests.swift
//  CharactersUITests
//
//  Created by Mohamed Farid on 30/05/2024.
//

import XCTest

final class CharactersUITests: XCTestCase {
    
    // MARK: Setup Methods
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments =  ["enable-testing"]
        app.launch()
    }
}

// MARK: - Test Cases

extension CharactersUITests {
    
    func testCharactersCollectionViewIsLoaded() {
        let app = XCUIApplication()
        
        let collectionView = app.collectionViews.firstMatch
        let cellsCount = collectionView.cells.count
        XCTAssertTrue(cellsCount > 0)
    }
    
    func testDetailsScreenComponentsExistence() {
        let app = XCUIApplication()
        
        let collectionView = app.collectionViews.firstMatch
        let indexPath = IndexPath(item: 1, section: 1)
        let cell = collectionView.cells.element(boundBy: indexPath.item)
        
        cell.tap()
        
        let backButton = app.buttons[AccessibilityIdentifiers.backButton]
        XCTAssertTrue(backButton.exists, "The Back Button should exists")
        
        let characterImageView = app.images[AccessibilityIdentifiers.characterImageView]
        XCTAssertTrue(characterImageView.exists, "The character image view should exists")
        
        let characterName = app.staticTexts[AccessibilityIdentifiers.characterName]
        XCTAssertTrue(characterName.exists, "The character name should exists")
        
        let locationText = app.staticTexts[AccessibilityIdentifiers.locationText]
        XCTAssertTrue(locationText.exists, "The location text should exists")
        
        let speciesGenderText = app.staticTexts[AccessibilityIdentifiers.speciesGenderText]
        XCTAssertTrue(speciesGenderText.exists, "The species gender text should exists")
        
        let statusText = app.staticTexts[AccessibilityIdentifiers.statusText]
        XCTAssertTrue(statusText.exists, "The status text should exists")
    }
}
