//
//  Task.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct Task: Identifiable {
  let id = UUID()
  var fieldValues: [FieldValue]

  func value(for field: Field) -> FieldValue? {
    fieldValues.first { $0.field.id == field.id }
  }
}
