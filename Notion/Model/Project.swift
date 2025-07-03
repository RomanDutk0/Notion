//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


struct Project: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var cards: [Card]
    var fieldsTemplate: [CardField]
    
    init(id: UUID, name: String, cards: [Card], fieldsTemplate: [CardField]) {
        self.id = id
        self.name = name
        self.cards = cards
        self.fieldsTemplate = fieldsTemplate
    }
}
