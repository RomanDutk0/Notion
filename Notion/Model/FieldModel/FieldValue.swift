//
//  FieldValue.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct FieldValue: Identifiable {
  let id = UUID()
  let field: Field
  var value: FieldDataValue
}
