//
//  CharactersListViewController.swift
//  Characters
//
//  Created by Mohamed Farid on 30/05/2024.
//

import UIKit
import SnapKit

class CharactersListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = CharactersListViewModel()
    
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
            return self.statusesLayout()
        }
    }
    
    // MARK: - Life Cycle View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.addSubviewsConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
}

// MARK: - Setup Navigation Appearance

extension CharactersListViewController {
    private func setupNavigationBar() {
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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

// MARK: - Add Subviews

extension CharactersListViewController {
    
    private func addSubviews() {
        self.addStatusesCollectionView()
    }
    
    private func addSubviewsConstraints() {
        self.addStatusesCollectionViewConstraints()
    }
}

// MARK: - Add Statuses Collection View

extension CharactersListViewController {
    
    private func addStatusesCollectionView() {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset.left = 16
        
        self.collectionView.register(StatusCollectionViewCell.self)
        self.view.addSubview(self.collectionView)
    }
    
    private func addStatusesCollectionViewConstraints() {
        self.collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
    }
}

// MARK: - Collection View Layouts

extension CharactersListViewController {
    
    private func statusesLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1.0), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}

// MARK: - Collection View Data Source

extension CharactersListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.characterStatuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(StatusCollectionViewCell.self, for: indexPath)
        cell.setup(with: self.viewModel.status(by: indexPath.item) ?? "")
        return cell
    }
}

// MARK: - Collection View Delegate

extension CharactersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == self.viewModel.selectedStatusIndex {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.viewModel.getCharacters()
        } else {
            self.viewModel.getCharacters(by: indexPath.item)
        }
    }
}
