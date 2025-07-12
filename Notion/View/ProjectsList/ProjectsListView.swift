//
//  ProjectsListView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct ProjectsListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Jump back in")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            JumpCard(title: "Projects", icon: "arrow.2.circlepath")
                            JumpCard(title: "Quarterly sales planning", icon: "book.closed")
                            JumpCard(title: "Tasks", icon: "checkmark.circle")
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("Private")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        Spacer()
                        Button {
                            print("Add tapped")
                        } label: {
                            Image(systemName: "plus")
                                .padding(10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                        }
                    }
                    
                    VStack(spacing: 12) {
                        ProjectRow(project: Project(
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
                                ]),
                                Task(fieldValues: [
                                    FieldValue(
                                        field: Field(name: "Name", type: .text),
                                        value: .text("📝 Write Documentation")
                                    ),
                                    FieldValue(
                                        field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]),
                                        value: .selection("Not Started")
                                    ),
                                    FieldValue(
                                        field: Field(name: "End Date", type: .date),
                                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 10))
                                    )
                                ]),
                                Task(fieldValues: [
                                    FieldValue(
                                        field: Field(name: "Name", type: .text),
                                        value: .text("🎨 Design New Logo")
                                    ),
                                    FieldValue(
                                        field: Field(name: "Status", type: .selection, options: ["Completed", "In Progress"]),
                                        value: .selection("Completed")
                                    ),
                                    FieldValue(
                                        field: Field(name: "End Date", type: .date),
                                        value: .date(Date().addingTimeInterval(-60 * 60 * 24 * 5))
                                    )
                                ])
                            ]
                        ))
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.white)
            .navigationTitle("Dashboard")
        }
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}

