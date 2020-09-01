//
//  SectionHeader.swift
//  iLetter
//
//  Created by Дарья on 30.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView{
    
    static let reuseId = "SectionHeader"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configure(text: String, textColor: UIColor, font: UIFont?){
        title.text = text
        title.textColor = textColor
        title.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
