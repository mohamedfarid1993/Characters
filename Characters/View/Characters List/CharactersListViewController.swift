//
//  CharactersListViewController.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import UIKit
import SnapKit
import Combine
import SwiftUI

class CharactersListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: CharactersListViewModel
    
    private lazy var collectionView = UICollectionView { [weak self] sectionIndex, layoutEnvironment in
        guard let self = self, sectionIndex < self.viewModel.sections().count else {
            let size = NSCollectionLayoutSize(widthDimension: .absolute(0), heightDimension: .absolute(0))
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
            return NSCollectionLayoutSection(group: group)
        }
        
        switch self.viewModel.sections()[sectionIndex] {
        case .statuses:
            return self.statusesLayout()
        case .characters:
            return self.charactersLayout()
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Initializers
    
    init(api: API.Type) {
        self.viewModel = CharactersListViewModel(api: api)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.addSubviewsConstraints()
        self.subscribeToViewModelStatePublisher()
        self.viewModel.getCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
}

// MARK: - Setup Navigation Appearance

extension CharactersListViewController {
    private func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.Colors.titlesDarkPurple]
        standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.Colors.titlesDarkPurple]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.clear
        standardAppearance.shadowImage = UIImage()
        standardAppearance.shadowColor = nil
        
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}

// MARK: - Subscriptions

extension CharactersListViewController {
    
    private func subscribeToViewModelStatePublisher() {
        self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                switch self.viewModel.state {
                case .loading:
                    self.handleLoading()
                case .loaded:
                    self.handleLoaded()
                case .failed(let error):
                    self.handleFailed(error)
                }
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: - State Handlers

extension CharactersListViewController {
    
    private func handleLoading() {
        self.showActivityIndicator()
        self.collectionView.isScrollEnabled = false
    }
    
    private func handleLoaded() {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = true
        let sectionsToReload = IndexSet(integer: 1) // Reload only characters section
        if self.collectionView.numberOfSections == 1 {
            self.collectionView.insertSections(sectionsToReload)
        } else {
            self.collectionView.reloadSections(sectionsToReload)
        }
        DispatchQueue.main.async { [weak self] in
            if let selectedStatusIndex = self?.viewModel.selectedStatusIndex,
               let cell = self?.collectionView.cellForItem(at: IndexPath(item: selectedStatusIndex, section: 0)) as? StatusCollectionViewCell {
                cell.isSelected = true
            }
        }
    }
    
    private func handleFailed(_ error: Error) {
        self.hideActivityIndicator()
        self.collectionView.isScrollEnabled = false
        self.showErrorAlert(with: error.localizedDescription)
    }
    
    private func showErrorAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.viewModel.getCharacters(by: self?.viewModel.selectedStatusIndex)
        }
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Add Subviews

extension CharactersListViewController {
    
    private func addSubviews() {
        self.addCollectionView()
    }
    
    private func addSubviewsConstraints() {
        self.addCollectionViewConstraints()
    }
}

// MARK: - Activity Indicator

extension CharactersListViewController {
    
    // MARK: Show Activity Indicator
    
    private func showActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.collectionView.backgroundView = self.activityIndicator
    }
    
    // MARK: Hide Activity Indicator
    
    private func hideActivityIndicator() {
        self.collectionView.backgroundView = nil
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - Add Collection View

extension CharactersListViewController {
    
    private func addCollectionView() {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = true
        
        self.collectionView.register(StatusCollectionViewCell.self)
        self.collectionView.register(CharacterCollectionViewCell.self)
        self.view.addSubview(self.collectionView)
    }
    
    private func addCollectionViewConstraints() {
        self.collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Collection View Layouts

extension CharactersListViewController {
    
    private func statusesLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func charactersLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16)
        
        return section
    }
}

// MARK: - Collection View Data Source

extension CharactersListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.viewModel.sections().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = self.viewModel.sections()
        switch sections[indexPath.section] {
        case .statuses:
            let cell = collectionView.dequeue(StatusCollectionViewCell.self, for: indexPath)
            cell.setup(with: self.viewModel.status(by: indexPath.item) ?? "")
            return cell
        case .characters:
            let cell = collectionView.dequeue(CharacterCollectionViewCell.self, for: indexPath)
            guard let character = self.viewModel.character(by: indexPath.item) else { return UICollectionViewCell() }
            cell.setup(with: character)
            return cell
        }
    }
}

// MARK: - Collection View Delegate

extension CharactersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sections = self.viewModel.sections()
        switch sections[indexPath.section] {
        case .statuses:
            guard indexPath.item != self.viewModel.selectedStatusIndex else { return }
            // Deselect all statuses except current selected status
            collectionView.indexPathsForSelectedItems?.filter({ $0 != indexPath }).forEach { collectionView.deselectItem(at: $0, animated: false) }
            self.viewModel.getCharacters(by: indexPath.item)
        case .characters:
            guard let character = self.viewModel.character(by: indexPath.item) else { return }
            let characterDetailsView = CharacterDetailsView(character: character)
            let hostingController = UIHostingController(rootView: characterDetailsView)
            self.navigationController?.pushViewController(hostingController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.viewModel.getCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.fetchNextPage(at: indexPath)
    }
}

// MARK: - Scroll View Delegate

extension CharactersListViewController {
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true) // To handle bug with the transition from display mode Large Title to Inline
    }
}
