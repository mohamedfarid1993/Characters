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
        case loading, loaded(characters: [Character])
        case failed(error: Error)
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

    var characterStatuses = ["alive", "dead", "unknown"]
    
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
                self?.state = .loaded(characters: response.characters)
            })
            .store(in: &self.subscriptions)
    }
    
    // MARK: - Get Characters By Status
    
    func getCharacters(by index: Int) {
        guard index != self.selectedStatusIndex else { return }
        self.selectedStatusIndex = index
    }
}

// MARK: - Data Source

extension CharactersListViewModel {
    
    func sections() -> [Section] {
        [.statuses, .characters]
    }
    
    func status(by index: Int) -> String? {
        index < self.characterStatuses.count ? self.characterStatuses[index] : nil
    }
}
