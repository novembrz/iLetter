//
//  LetterUser.swift
//  iLetter
//
//  Created by Дарья on 01.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit

struct LetterUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LetterUser, rhs: LetterUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains (filter: String?) -> Bool {
        guard let filter = filter else {return true}
        if filter.isEmpty {return true}
        
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
