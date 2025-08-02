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
  @State private var projectToDelete: Project?
  @State private var searchText = ""

  @StateObject var projectModel = ProjectViewModel.getInstance()
  @State private var isSearching = false

  var filteredProjects: [Binding<Project>] {
    let allProjects = $projectModel.projects

    // створюємо [Binding<Project>] за індексами
    let projectBindings = allProjects.wrappedValue.indices.map { index in
      Binding(
        get: { allProjects.wrappedValue[index] },
        set: { allProjects.wrappedValue[index] = $0 }
      )
    }

    // фільтрація за searchText
    return searchText.isEmpty
      ? projectBindings
      : projectBindings.filter {
        $0.wrappedValue.projectName.lowercased().contains(searchText.lowercased())
      }
  }

  var body: some View {
    NavigationStack {
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
          Text("Projects")
            .font(.title3)
            .fontWeight(.semibold)

          Spacer()

          if isSearching {
            HStack(spacing: 8) {
              TextField("Search...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 180)

              Button(action: {
                withAnimation {
                  searchText = ""
                  isSearching = false
                }
              }) {
                Image(systemName: "xmark.circle.fill")
                  .foregroundColor(.gray)
              }
            }
            .transition(.move(edge: .trailing))
          } else {
            Button {
              withAnimation {
                isSearching = true
              }
            } label: {
              Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
            }
          }

          Button {
            showDetail = true
          } label: {
            Image(systemName: "plus")
              .padding(10)
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .sheet(isPresented: $showDetail) {
            CardConstructorView()
          }
        }
        .padding(.horizontal)

        List {
          ForEach(filteredProjects) { $project in
            ProjectRow(project: $project) {
              projectToDelete = project
              showDeleteConfirmation = true
            }
            .listRowSeparator(.hidden)
          }
          .onMove(perform: moveProject)
        }
        .listStyle(.plain)
      }
      .navigationTitle("Dashboard")
      .confirmationDialog(
        "Are you sure you want to delete this project?", isPresented: $showDeleteConfirmation
      ) {
        Button("Delete", role: .destructive) {
          if let project = projectToDelete,
            let index = projectModel.projects.firstIndex(where: { $0.id == project.id })
          {
            withAnimation {
              projectModel.projects.remove(at: index)
            }
          }
        }
        Button("Cancel", role: .cancel) {}
      }
    }
  }

  private func moveProject(from source: IndexSet, to destination: Int) {
    projectModel.projects.move(fromOffsets: source, toOffset: destination)
  }
}

struct ProjectsListView_Previews: PreviewProvider {
  static var previews: some View {
    ProjectsListView()
  }
}
