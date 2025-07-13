//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


struct Project : Identifiable {
    let id = UUID()
    var icon: String
    var projectName : String
    var taskCards : [Task]
    
}

struct SubTask: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}


struct Task: Identifiable {
    let id = UUID()
    var fieldValues: [FieldValue]
}

struct FieldValue: Identifiable {
    let id = UUID()
    let field: Field
    var value: FieldDataValue
}

struct Field: Identifiable {
    let id = UUID()
    var name: String
    var type: FieldType
    var options: [String] = []
}


enum FieldType: String, CaseIterable, Identifiable {
    case text = "Text"
    case number = "Number"
    case boolean = "Boolean"
    case date = "Date"
    case url = "URL"
    case selection = "Selection"
    
    var id: String { self.rawValue }
}


enum FieldDataValue {
    case text(String)
    case number(Double)
    case boolean(Bool)
    case date(Date)
    case url(String)
    case selection(String)
}
