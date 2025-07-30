//
//  ProjectViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUI


@MainActor
class ProjectViewModel : ObservableObject
{
    
    static let shared = ProjectViewModel()
    
    @Published var projects : [Project] = [
        Project(
            id: UUID(),
            icon: "📝",
            projectName: "Notion",
            taskCards: [
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Product Launch")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["In Progress"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["In Progress1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Product Launch")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["In Progress"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["In Progress1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Product")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["Not Started"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["Done1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(30 * 30 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Product Launch")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["In Progress"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["Done1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Launch")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["Done"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["In Progress1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🚀 Product Launch")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["In Progress"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["In Progress1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(30 * 60 * 24 * 30))
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("📝 Write Documentation")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]),
                        value: .selection(["Not Started"])
                    ),
                    FieldValue(
                        field: Field(name: "GO", type: .selection, options: ["In Progress1", "Done1"]),
                        value: .selection(["Done1"])
                    ),
                    FieldValue(
                        field: Field(name: "End Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 10))
                    )
                ])
            ] ,
            template: [
                        FieldValue(field: Field(name: "Name", type: .text), value: .text("")),
                        FieldValue(field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]), value: .selection(["Not Started"])),
                        FieldValue(field: Field(name: "GO", type: .selection, options: ["Not Started1", "In Progress1", "Done1"]), value: .selection(["Not Started1"])),
                        FieldValue(field: Field(name: "End Date", type: .date), value: .date(Date()))
                    ]
        ),
        Project(
            id: UUID(),
            icon: "📚",
            projectName: "Learning SwiftUI",
            taskCards: [
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("👨‍💻 Read Documentation")
                    ),
                    FieldValue(
                        field: Field(name: "Completed", type: .boolean),
                        value: .boolean(false)
                    ),
                    FieldValue(
                        field: Field(name: "Progress", type: .number),
                        value: .number(40)
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🧪 Build Prototype")
                    ),
                    FieldValue(
                        field: Field(name: "Completed", type: .boolean),
                        value: .boolean(true)
                    ),
                    FieldValue(
                        field: Field(name: "Progress", type: .number),
                        value: .number(100)
                    )
                ])
            ],
            template: [
                        FieldValue(field: Field(name: "Name", type: .text), value: .text("")),
                        FieldValue(field: Field(name: "Completed", type: .boolean), value: .boolean(false)),
                        FieldValue(field: Field(name: "Progress", type: .number), value: .number(0))
                    ]
        ),
        Project(
            id: UUID(),
            icon: "🌐",
            projectName: "Website Redesign",
            taskCards: [
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("🎨 Create Mockups")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                        value: .selection(["Done"])
                    ),
                    FieldValue(
                        field: Field(name: "Preview URL", type: .url),
                        value: .text("https://example.com/mockups")
                    )
                ]),
                Task(fieldValues: [
                    FieldValue(
                        field: Field(name: "Name", type: .text),
                        value: .text("💻 Develop Landing Page")
                    ),
                    FieldValue(
                        field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]),
                        value: .selection(["In Progress"])
                    ),
                    FieldValue(
                        field: Field(name: "Launch Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 60))
                    )
                ])
            ],
            template: [
                        FieldValue(field: Field(name: "Name", type: .text), value: .text("")),
                        FieldValue(field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]), value: .selection(["Not Started"])),
                        FieldValue(field: Field(name: "Launch Date", type: .date), value: .date(Date()))
                    ]
        )
    ]
    
    private init() { }
    
    static func getInstance() -> ProjectViewModel {
           return shared
       }
    
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
        optionsString: String,
        fields  :  inout [Field]
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

    
    static func saveProject(projects: inout [Project], fields: [Field], projectIcon: String, projectName: String) {
        let templateFieldValues: [FieldValue] = fields.map { field in
            let value: FieldDataValue
            switch field.type {
            case .text:
                value = .text("")
            case .selection:
                value = .selection([field.options.first ?? ""])
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
        }


        let newTask = Task(fieldValues: templateFieldValues)

        let newProject = Project(icon: projectIcon, projectName: projectName, taskCards: [newTask], template: templateFieldValues)

        projects.append(newProject)

        print("✅ Project added. Total projects: \(projects.count)")
    }

    
    static func deleteProject(_ projects: inout [Project] , _ project : Project) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects.remove(at: index)
            print("Deleted")
        }
    }

    func template(forTask task: Task?) -> [FieldValue]? {
            guard let task = task else { return nil }
            for project in projects {
                if project.taskCards.contains(where: { $0.id == task.id }) {
                    return project.templateOfFieldValues
                }
            }
            return nil
        }


    
}


