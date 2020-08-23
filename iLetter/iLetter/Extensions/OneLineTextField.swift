//
//  OneLineTextField.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class OneLineTextField: UITextField {
    
    convenience init(font: UIFont? = .avenir20()) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var lineView = UIView()
        lineView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .tfGray()
        
        self.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
