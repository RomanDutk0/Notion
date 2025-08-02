//
//  Field.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct Field: Identifiable {
  let id = UUID()
  var name: String
  var type: FieldType
  var options: [String] = []
}
