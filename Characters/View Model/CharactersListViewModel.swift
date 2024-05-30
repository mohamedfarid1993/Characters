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
        case loading, loaded(characters: [String])
        case failed(error: Error)
    }
    
    // MARK: Properties
    
    @Published var state: State = .loading
    
    private let api: API.Type
    private var subscriptions = Set<AnyCancellable>()

    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
        self.getCharacters()
    }
}

// MARK: - Networking Methods

extension CharactersListViewModel {
    
    // MARK: Get Characters
    
    private func getCharacters() {
        self.state = .loading
        
        self.api
            .getCharacters()
            .sink(receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(error: error)
            }, receiveValue: { [weak self] characters in
                self?.state = .loaded(characters: [])
            })
            .store(in: &self.subscriptions)
    }
}
