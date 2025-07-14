//
//  FieldType.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation



enum FieldType: String, CaseIterable, Identifiable {
    case text = "Text"
    case number = "Number"
    case boolean = "Boolean"
    case date = "Date"
    case url = "URL"
    case selection = "Selection"
    
    var id: String { self.rawValue }
}
