//
//  Card.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation

struct Card : Codable {
    
    let id : UUID
    var fields : [String : CardFieldValue]
    
    init(id: UUID, fields: [String : CardFieldValue]) {
        self.id = id
        self.fields = fields
    }
}
