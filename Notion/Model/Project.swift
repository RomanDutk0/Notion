//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


struct Project {
    let id = UUID()
    var icon: String
    var projectName : String
    var taskCards : [Task]
    
    func getAllFields() -> [Field]{
        var projectFields : [Field] = []
        
        for field in self.taskCards[0].fieldValues{
            projectFields.append(field.field)
        }
        return projectFields
    }
    
}

struct SubTask: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool
}


struct Task: Identifiable {
    let id = UUID()
    var fieldValues: [FieldValue]
    
    static func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
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
