//
//  ProjectViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUI

class ProjectViewModel : ObservableObject
{
    @Published var projects : [Project] = []
    
    
    static func numberOfCards(project : Project)-> Int{
        return project.taskCards.count
    }
    
    static func getAllFields(_ project : Project) -> [Field] {
           var projectFields: [Field] = []
           
            guard
                 !project.taskCards.isEmpty,
                 !project.taskCards[0].fieldValues.isEmpty else {
               return projectFields
           }
           
           for fieldValue in project.taskCards[0].fieldValues {
               projectFields.append(fieldValue.field)
           }
           
           return projectFields
       }
       
    
    func setProjectFields()
    {
    
    }
    
    static  func addField(
        name: String,
        type: FieldType,
        optionsString: String, fields  :  inout [Field]
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            print("Field name is empty — not adding")
            return
        }

        var options: [String] = []
        if type == .selection {
            options = optionsString
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
        }

        let field = Field(name: trimmedName, type: type, options: options)
        fields.append(field)

    }

    
    static func saveProject(projects : inout [Project] , fields : [Field] , projectIcon: String , projectName: String  ) {
        let newTask = Task(fieldValues: fields.map { field in
            let value: FieldDataValue
            switch field.type {
            case .text:
                value = .text("")
            case .selection:
                value = .selection(field.options.first ?? "")
            case .number:
                value = .number(0)
            case .boolean:
                value = .boolean(false)
            case .date:
                value = .date(Date())
            case .url:
                value = .text("https://example.com")
            }
            return FieldValue(field: field, value: value)
        })
        
        let newProject = Project(icon: projectIcon, projectName: projectName, taskCards: [newTask])
        projects.append(newProject)
        
        print("✅ Project added. Total projects: \(projects.count)")
    }
    
    static func deleteProject(_ projects: inout [Project] , _ project : Project) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects.remove(at: index)
            print("Deleted")
        }
    }

    
}


