//
//  ButtonFormView.swift
//  iLetter
//
//  Created by Дарья on 23.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class ButtonFormView: UIView {
    
    init(label: UILabel, button: UIButton){
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true // говорим всему стеку, что них равен низу кнопки
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
