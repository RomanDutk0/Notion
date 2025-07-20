//
//  ProjectsListView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

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

    @ObservedObject var projectModel : ProjectViewModel
    
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
                        CardConstructorView(projects: $projectModel.projects)
                    }
                }
                
                List {
                    ForEach($projectModel.projects) { $project in
                        ProjectRow(project: $project) {
                            projectToDelete = project
                            showDeleteConfirmation = true
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .confirmationDialog("Are you sure you want to delete this project?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        if let project = projectToDelete,
                           let index = projectModel.projects.firstIndex(where: { $0.id == project.id }) {
                            projectModel.projects.remove(at: index)
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
        //ProjectsListView()
    }
}



