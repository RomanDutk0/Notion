//
//  ProjectRowView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI
struct ProjectRow: View {
    var project: Project
    var onRequestDelete: () -> Void

    @State private var showDeleteConfirmation = false
    @State private var navigate = false

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
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                }
                .padding(.trailing , 20)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                navigate = true
            }
        }
        .background(
            NavigationLink(
                destination: TaskTreckerView(
                    tasks: project.taskCards,
                    fields: ProjectViewModel.getAllFields(project)),
                isActive: $navigate,
                label: { EmptyView() }
            )
            .hidden()
        )
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
        .swipeActions {
            Button(role: .destructive) {
                showDeleteConfirmation = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
