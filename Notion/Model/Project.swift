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

    init(id: UUID = UUID(), icon: String, projectName: String, taskCards: [Task]) {
        self.id = id
        self.icon = icon
        self.projectName = projectName
        self.taskCards = taskCards
    }
}










