//
//  LetterChat.swift
//  iLetter
//
//  Created by Дарья on 01.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

struct LetterChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LetterChat, rhs: LetterChat) -> Bool {
        return lhs.id == rhs.id
    }
}
