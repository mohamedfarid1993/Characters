//
//  CharactersListViewModel.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import Foundation
import Combine

class CharactersListViewModel: ObservableObject {
    enum State {
        case loading, loaded, failed(error: Error)
    }
    
    enum Section {
        case statuses
        case characters
    }
    
    // MARK: Properties
    
    @Published var state: State = .loading
    
    private let api: API.Type
    private var subscriptions = Set<AnyCancellable>()
    private(set) var selectedStatusIndex: Int? = nil

    private var characterStatuses = ["alive", "dead", "unknown"]
    private var characters: [Character] = []
    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
        self.getCharacters()
    }
}

// MARK: - Networking Methods

extension CharactersListViewModel {
    
    // MARK: Get Characters
    
    func getCharacters() {
        self.selectedStatusIndex = nil
        self.state = .loading
        
        self.api
            .getCharacters()
            .sink(receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(error: error)
            }, receiveValue: { [weak self] response in
                self?.characters = response.characters
                self?.state = .loaded
            })
            .store(in: &self.subscriptions)
    }
    
    // MARK: - Get Characters By Status
    
    func getCharacters(by index: Int) {
        guard index != self.selectedStatusIndex else { return }
        self.selectedStatusIndex = index
        self.state = .loading
    }
}

// MARK: - Data Source

extension CharactersListViewModel {
    
    func sections() -> [Section] {
        [.statuses, .characters]
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch self.sections()[section] {
        case .statuses:
            return self.characterStatuses.count
        case .characters:
            return self.characters.count
        }
    }
    
    func status(by index: Int) -> String? {
        index < self.characterStatuses.count ? self.characterStatuses[index] : nil
    }
}
