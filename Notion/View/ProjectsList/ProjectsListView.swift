//
//  ProjectsListView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct ProjectsListView: View {
    
    @State private var showDetail = false
    @State private var showDeleteConfirmation = false
    @State private var projectToDelete: Project? = nil

    
    
    @State var sampleProjects: [Project] = [
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
                ])
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
                        value: .selection("Done")
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
                        value: .selection("In Progress")
                    ),
                    FieldValue(
                        field: Field(name: "Launch Date", type: .date),
                        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 60))
                    )
                ])
            ]
        )
    ]
    
    
    var body: some View {
        NavigationView {
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
                        showDetail = true
                    } label: {
                        Image(systemName: "plus")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 10)
                    }
                    .sheet(isPresented: $showDetail) {
                        CardConstructorView(projects: $sampleProjects)
                    }
                }
                
                List {
                    ForEach(Array(sampleProjects.enumerated()), id: \.element.id) { index, project in
                        ProjectRow(project: project) {
                            projectToDelete = project
                            showDeleteConfirmation = true
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .confirmationDialog("Are you sure you want to delete this project?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        if let project = projectToDelete,
                           let index = sampleProjects.firstIndex(where: { $0.id == project.id }) {
                            sampleProjects.remove(at: index)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }

            }
            .navigationTitle("Dashboard")
        }
    }
    
}
struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}

