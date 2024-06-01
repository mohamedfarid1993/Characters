//
//  UICollectioView.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit

// MARK: - Initializers

extension UICollectionView {
    convenience init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider) {
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        self.init(frame: .zero, collectionViewLayout: compositionalLayout)
    }
}

// MARK: - Register Reusable

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ classType: T.Type) {
        let reuseIdentifier = String(describing: T.self)
        
        self.register(classType, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Dequeue Reusable

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        let dequeuedCell = self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let cell = dequeuedCell as? T else {
            fatalError("\(T.self) is not registered")
        }
        
        return cell
    }
}
