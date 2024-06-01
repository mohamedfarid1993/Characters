//
//  CharacterCollectionViewCell.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let contentStackView = UIStackView(axis: .vertical, spacing: 4, alignment: .top, distribution: .fillProportionally)

    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let imageView = UIImageView()
    
    private let imageDimension: CGFloat = 90
    
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
        ImageProvider.loadImage(with: URL(string: character.image),
                                into: self.imageView,
                                using: ImageProvider.Configuration(placeholder: UIImage(systemName: "person.crop.circle"),
                                                                   size: CGSize(width: self.imageDimension, height: self.imageDimension)))
        
        switch character.gender {
        case .male:
            self.contentView.backgroundColor = Theme.Colors.maleLightBlue
            self.contentView.layer.borderColor = Theme.Colors.maleLightBlue.cgColor
        case .female:
            self.contentView.backgroundColor = Theme.Colors.femaleLightPink
            self.contentView.layer.borderColor = Theme.Colors.femaleLightPink.cgColor
        case .unknown, .genderless:
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
        self.imageView.layer.cornerRadius = 10
        self.contentView.addSubview(self.imageView)
    }
    
    private func addImageViewConstraints() {
        self.imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(self.imageDimension)
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
        self.nameLabel.font = .boldSystemFont(ofSize: 18)
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
