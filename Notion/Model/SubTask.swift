//
//  SubTask.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct SubTask: Identifiable {
  let id = UUID()
  var title: String
  var isDone: Bool
}
