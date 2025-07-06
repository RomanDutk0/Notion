//
//  CardField.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


struct CardField: Codable, Hashable {
    
    var name: String
    var type: CardFieldType
    var selectionOptions: [String]?
    
    init(name: String, type: CardFieldType, selectionOptions: [String]? = nil) {
        self.name = name
        self.type = type
        self.selectionOptions = selectionOptions
    }
    
}
