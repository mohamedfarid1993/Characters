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
    
    enum Section: Int {
        case statuses = 0
        case characters = 1
    }
    
    // MARK: Properties
    
    @Published var state: State = .loading
    
    private let api: API.Type
    private var subscriptions = Set<AnyCancellable>()
    private(set) var selectedStatusIndex: Int? = nil

    private var characterStatuses = ["alive", "dead", "unknown"]
    private var characters: [Character] = []
    private var page = 1
    private var info: Info?
    
    // MARK: Initializers
    
    init(api: API.Type = APIRouter.self) {
        self.api = api
    }
}

// MARK: - Networking Methods

extension CharactersListViewModel {
    
    // MARK: Get Characters
    
    func getCharacters(by index: Int? = nil) {
        if self.selectedStatusIndex != index { // Check to reset page & data
            self.selectedStatusIndex = index
            self.page = 1
            self.characters = []
            self.state = .loading
        } else if let info = self.info, info.next != nil {
            self.page += 1
        }
        
        var status: String? = nil
        if let index = index {
            status = self.status(by: index)
        }

        self.api
            .getCharacters(by: status, in: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(error: error)
            }, receiveValue: { [weak self] response in
                self?.characters += response.characters
                self?.info = response.info
                self?.state = .loaded
            })
            .store(in: &self.subscriptions)
    }
}

// MARK: - Data Source

extension CharactersListViewModel {
    
    func sections() -> [Section] {
        switch self.state {
        case .loading, .failed:
            return [.statuses]
        case .loaded:
            return [.statuses, .characters]
        }
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
    
    func character(by index: Int) -> Character? {
        index < self.characters.count ? self.characters[index] : nil
    }
        
    func fetchNextPage(at indexPath: IndexPath) {
        guard indexPath.section == Section.characters.rawValue else { return }
        switch self.state {
        case .loading:
            return
        default:
            let beforeLastIndex = self.numberOfItems(in: Section.characters.rawValue) - 2
            guard indexPath.item == beforeLastIndex else { return }
            self.getCharacters(by: self.selectedStatusIndex)
        }
    }
}
