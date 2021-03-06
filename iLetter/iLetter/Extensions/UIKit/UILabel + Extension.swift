//
//  UILabel + Extension.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20()){
        self.init()
        self.text = text
        self.font = font
    }
}
