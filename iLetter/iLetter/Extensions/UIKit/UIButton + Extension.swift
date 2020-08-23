//
//  Button + Extension.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(title: String,
                     font: UIFont? = .avenir20(),
                     backgroundColor: UIColor,
                     titleColor: UIColor,
                     cornerRadius: CGFloat = 4,
                     isShadow: Bool){
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        if isShadow{
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2 // блик
            self.layer.shadowRadius = 4
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }

    }
}