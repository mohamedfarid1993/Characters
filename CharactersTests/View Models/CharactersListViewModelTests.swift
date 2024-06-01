//
//  CharactersListViewModelTests.swift
//  CharactersTests
//
//  Created by Mohamed Farid on 01/06/2024.
//

import XCTest
import Combine
@testable import Characters

class CharactersListViewModelTests: XCTestCase {
    
    // MARK: Properties
    
    var viewModel: CharactersListViewModel!
    var subscriptions: Set<AnyCancellable>!
    
    // MARK: Setup Methods
    
    override func setUpWithError() throws {
        self.subscriptions = Set<AnyCancellable>()
        self.viewModel = CharactersListViewModel(api: MockAPI.self)
    }
    
    override func tearDownWithError() throws {
        self.subscriptions = nil
        self.viewModel = nil
    }
}

// MARK: - Test Cases

extension CharactersListViewModelTests {
    
    func testGetDataShouldCallAPI() {
        let expectation = XCTestExpectation()
        
        self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .loaded = state {
                    expectation.fulfill()
                }
            }
            .store(in: &self.subscriptions)
        
        self.viewModel.getCharacters()
        wait(for: [expectation], timeout: 1)
    }
    
    func testSectionsDuringLoading() {
        let sections = self.viewModel.sections()

        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0], .statuses)
    }
    
    func testSectionsAfterLoadingCharacters() {
        let expectation = XCTestExpectation()
        
        self.viewModel.$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .loaded = state {
                    let sections = self.viewModel.sections()
                    XCTAssertEqual(sections[0], .statuses)
                    XCTAssertEqual(sections[1], .characters)
                    expectation.fulfill()
                }
            }
            .store(in: &self.subscriptions)
        
        self.viewModel.getCharacters()
        wait(for: [expectation], timeout: 1)
    }
    
    func testNumberOfItemsInSection() {
        let expectation = XCTestExpectation()
        
        self.viewModel.$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .loaded = state {
                    let statuses = self.viewModel.numberOfItems(in: 0)
                    XCTAssertEqual(statuses, 3)
                    expectation.fulfill()
                }
            }
            .store(in: &self.subscriptions)
        
        self.viewModel.getCharacters()
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetStatusByIndex() {
        let firstStatus = self.viewModel.status(by: 0)
        let nonExistantStatus = self.viewModel.status(by: 10)
        
        XCTAssertNotNil(firstStatus)
        XCTAssertNil(nonExistantStatus)
    }
    
    func testGetCharacterByIndex() {
        let expectation = XCTestExpectation()
        
        self.viewModel.$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case .loaded = state {
                    let firstCharacter = self.viewModel.character(by: 0)
                    let nonExistantCharacter = self.viewModel.character(by: 100)
                    
                    XCTAssertNotNil(firstCharacter)
                    XCTAssertNil(nonExistantCharacter)
                    expectation.fulfill()
                }
            }
            .store(in: &self.subscriptions)
        
        self.viewModel.getCharacters()
        wait(for: [expectation], timeout: 1)
    }
}
