//
//  SelfConfiguringCell.swift
//  iLetter
//
//  Created by Дарья on 29.08.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with value: LetterChat)
}
