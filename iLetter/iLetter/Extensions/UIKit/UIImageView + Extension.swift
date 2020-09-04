//
//  UIImageView + Extension.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init (image: UIImage?, contentMode: UIView.ContentMode){
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
    func setupColor(color: UIColor){
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
