//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation

struct Project: Identifiable {
  let id: UUID
  var icon: String
  var projectName: String
  var taskCards: [Task]
  var templateOfFieldValues: [FieldValue]
  var viewOptions: [ViewOption]

  init(
    id: UUID = UUID(), icon: String, projectName: String, taskCards: [Task], template: [FieldValue]
  ) {
    self.id = id
    self.icon = icon
    self.projectName = projectName
    self.taskCards = taskCards
    self.templateOfFieldValues = template
    self.viewOptions = [
      ViewOption(title: "By Status", icon: "arrow.right", type: .board, groupByFieldName: "Status"),
      ViewOption(title: "All tasks", icon: "star", type: .table, groupByFieldName: "Status"),
    ]
  }
  init(
    id: UUID = UUID(), icon: String, projectName: String, taskCards: [Task], template: [FieldValue],
    viewOptions: [ViewOption]
  ) {
    self.id = id
    self.icon = icon
    self.projectName = projectName
    self.taskCards = taskCards
    self.templateOfFieldValues = template
    self.viewOptions = viewOptions

  }
}
