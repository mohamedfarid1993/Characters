//
//  CharacterCollectionViewCell.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let contentStackView = UIStackView(axis: .vertical, spacing: 8, alignment: .top, distribution: .fillProportionally)

    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.layer.borderColor = Theme.Colors.borderLightPurple.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
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
        self.nameLabel.text = character.name
        self.speciesLabel.text = character.species
        self.imageView.image = UIImage(systemName: "person.crop.circle")
        
        switch character.gender {
        case .male:
            self.contentView.backgroundColor = Theme.Colors.maleLightBlue
            self.contentView.layer.borderColor = Theme.Colors.maleLightBlue.cgColor
        case .female:
            self.contentView.backgroundColor = Theme.Colors.femaleLightPink
            self.contentView.layer.borderColor = Theme.Colors.femaleLightPink.cgColor
        case .unknown:
            self.contentView.backgroundColor = .clear
            self.contentView.layer.borderColor = Theme.Colors.borderLightPurple.cgColor
        }
        
        self.layoutIfNeeded()
    }
}

// MARK: - Add Subviews

extension CharacterCollectionViewCell {
    
    private func addSubviews() {
        self.addImageView()
        self.addContentStackView()
        self.addNameLabel()
        self.addSpeciesLabel()
    }
    
    private func addConstraints() {
        self.addImageViewConstraints()
        self.addContentStackViewConstraints()
    }
}

// MARK: - Add Image View

extension CharacterCollectionViewCell {
    
    private func addImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.tintColor = .black
        self.imageView.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.contentView.addSubview(self.imageView)
    }
    
    private func addImageViewConstraints() {
        self.imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(90)
        }
    }
}

// MARK: - Add Content Stack View

extension CharacterCollectionViewCell {
    
    private func addContentStackView() {
        self.contentView.addSubview(self.contentStackView)
    }
    
    private func addContentStackViewConstraints() {
        self.contentStackView.snp.makeConstraints {
            $0.leading.equalTo(self.imageView.snp.trailing).inset(-16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(self.imageView.snp.top).inset(8)
        }
    }
}


// MARK: - Add Name Label

extension CharacterCollectionViewCell {
    
    private func addNameLabel() {
        self.nameLabel.textColor = Theme.Colors.titlesDarkPurple
        self.contentStackView.addArrangedSubview(self.nameLabel)
    }
}

// MARK: - Add Species Label

extension CharacterCollectionViewCell {
    
    private func addSpeciesLabel() {
        self.speciesLabel.textColor = Theme.Colors.subtitlesLightPurple
        self.contentStackView.addArrangedSubview(self.speciesLabel)
    }
}
