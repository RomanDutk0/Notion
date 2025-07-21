//
//  ProjectEditorView.swift
//  Notion
//
//  Created by Admin on 21.07.2025.
//

import SwiftUI

struct ProjectEditor: View {
    @Binding var project: Project
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Group {
                        if isEditing {
                            TextField("", text: $project.icon, onCommit: { isEditing = false })
                                .frame(width: 60, alignment: .center)
                                .multilineTextAlignment(.center)
                        } else {
                            Text(project.icon)
                                .frame(width: 60, alignment: .center)
                        }
                    }
                    .font(.system(size: 50))
                    
                    Group {
                        if isEditing {
                            TextField("", text: $project.projectName, onCommit: { isEditing = false })
                                .frame(minWidth: 200, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(project.projectName)
                                .bold()
                                .frame(minWidth: 200, alignment: .leading)
                        }
                    }
                    .font(.system(size: 34, weight: .bold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                }
                .padding()
              
                List {
                    ForEach(project.taskCards.first?.fieldValues ?? []) { fieldValue in
                        VStack(alignment: .leading) {
                            Text(fieldValue.field.name)
                                .font(.headline)
                            Text("Type: \(fieldValue.field.type.rawValue)")
                                .font(.subheadline)
                            if fieldValue.field.type == .selection {
                                Text("Options: \(fieldValue.field.options.joined(separator: ", "))")
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Edit Project")
        }
    }
}


#Preview {
    ProjectEditor(project: .constant(
        Project(
            icon: "🚀",
            projectName: "My Project",
            taskCards: [
                Task(fieldValues: [
                    FieldValue(field: Field(name: "Name", type: .text), value: .text("Example")),
                    FieldValue(field: Field(name: "Priority", type: .selection, options: ["High", "Low"]), value: .selection("High"))
                ])
            ]
        )
    ))
}
