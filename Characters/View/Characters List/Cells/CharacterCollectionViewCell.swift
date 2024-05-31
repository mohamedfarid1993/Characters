//
//  CharacterCollectionViewCell.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    let statusLabel = UILabel()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.layer.borderColor = Theme.Colors.subtitlesLightPurple.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        self.addSubviews()
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

// MARK: - Setup View Methods

extension CharacterCollectionViewCell {
    
    func setup(with character: Character) {
        self.statusLabel.text = character.name
        self.layoutIfNeeded()
    }
}

// MARK: - Add Subviews

extension CharacterCollectionViewCell {
    
    private func addSubviews() {
        self.addStatusLabel()
    }
    
    private func addConstraints() {
        self.addStatusLabelConstraints()
    }
}

// MARK: - Add Category Label

extension CharacterCollectionViewCell {
    
    private func addStatusLabel() {
        self.statusLabel.textColor = Theme.Colors.titlesDarkPurple
        self.contentView.addSubview(self.statusLabel)
    }
    
    private func addStatusLabelConstraints() {
        self.statusLabel.snp.makeConstraints {
            $0.center.equalTo(self.contentView)
            $0.top.equalTo(self.contentView).offset(10)
            $0.leading.equalTo(self.contentView).offset(16)
        }
    }
}
