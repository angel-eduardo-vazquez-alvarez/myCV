//
//  CardView.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/20/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

// MARK: RoundedView
/// Custom view that rounds the corners of a view and colors it with a custom color.
@IBDesignable class RoundedView: UIView {
    
    // MARK: - IBInspectable properties
    /// Rounds the corners of the view in `n` points.
    @IBInspectable public var cornerRadius: CGFloat = 20 {
        didSet {
            updateCornerRadius()
        }
    }
    
    /// Controls whether this view has a shadow behind or not.
    @IBInspectable public var hasShadow: Bool = false {
        didSet {
            updateShadow()
        }
    }
    
    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
    
    private func updateShadow() {
        if hasShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = .zero
            layer.shadowRadius = cornerRadius
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        updateShadow()
    }
}
