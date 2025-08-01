//
//  Task.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct Task: Identifiable , Equatable {
    let id = UUID()
    var fieldValues: [FieldValue]
    
    
    func value(for field: Field) -> FieldValue? {
            fieldValues.first { $0.field.id == field.id }
        }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
          return lhs.id == rhs.id
      }
}
