//
//  UIStackView.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit

extension UIStackView {
    
    // MARK: Initializers
    
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = .zero, alignment: Alignment = .fill, distribution: Distribution = .fill) {
        self.init()
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
