//
//  ProjectRowView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI


struct ProjectRow: View {
    var project: Project

    var body: some View {
        NavigationLink(destination: TaskTreckerView(tasks: project.taskCards, fields:   ProjectViewModel.getAllFields(project))) {
            HStack {
                Text(project.icon)
                Text(project.projectName)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    NavigationStack {
        ProjectRow(
            project: Project(
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
                            value: .selection("In Progress")
                        ),
                        FieldValue(
                            field: Field(name: "End Date", type: .date),
                            value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                        )
                    ])
                ]
            )
        )
    }
}
