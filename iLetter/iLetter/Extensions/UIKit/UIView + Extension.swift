//
//  UIView + Extension.swift
//  iLetter
//
//  Created by Дарья on 03.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.4745098039, green: 0.8901960784, blue: 0.7490196078, alpha: 1), endColor: #colorLiteral(red: 0.4156862745, green: 0.8274509804, blue: 0.8352941176, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
