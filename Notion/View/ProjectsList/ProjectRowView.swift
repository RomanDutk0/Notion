//
//  ProjectRowView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI
struct ProjectRow: View {
    
    
    @ObservedObject var projectModel = ProjectViewModel.getInstance()
    @StateObject var cardModel : CardViewModel = CardViewModel()
    @Binding var project: Project
    var onRequestDelete: () -> Void
    @State private var navigate = false
    @State private var navigateToEditor = false

    var body: some View {
        HStack {
            HStack {
                Text(project.icon)
                Text(project.projectName)
                    .foregroundColor(.black)
                Spacer()
                Text("\(project.taskCards.count)")
                    .opacity(0.5)
                    .padding(.trailing , 30)

                Button {
                    print("Edit tapped")
                    navigateToEditor = true
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
                .padding(.trailing, 20)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                navigate = true
            }
        }
        .background(
            Group {
                    NavigationLink(
                        destination: TaskTreckerView(
                            project: $project,
                            fields: projectModel.getAllFields(project), cardModel: cardModel
                        ),
                        isActive: $navigate
                    ) {
                        EmptyView()
                    }

                    NavigationLink(
                        destination: ProjectEditor(project: $project),
                        isActive: $navigateToEditor
                    ) {
                        EmptyView()
                    }
                }
                .hidden()
        )
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
        .swipeActions {
            Button(role: .destructive) {
                onRequestDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
