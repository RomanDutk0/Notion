//
//  RowBoardView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct ProjectsTableView: View {
    
    @State private var columns: [Column] = [
        Column(title: "Project name", width: 200),
        Column(title: "Status", width: 120),
        Column(title: "End date", width: 120),
        Column(title: "Priority", width: 120),
        Column(title: "Start date", width: 120)
    ]

    var projects: [Project] 

    var body: some View {
        VStack(spacing: 0) {
            ScrollView([.horizontal]) {
                VStack(spacing: 0) {
                    HStack {
                        ForEach(columns) { column in
                            HStack {
                                Text(column.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    if let index = columns.firstIndex(of: column) {
                                        columns.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .imageScale(.small)
                                }
                            }
                            .frame(width: column.width, alignment: .leading)
                        }

                        Button(action: {
                            columns.append(Column(title: "New Column", width: 120))
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add Column")
                            }
                            .foregroundColor(.blue)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))

                    Divider()
                    
                    ForEach(projects) { project in
                        RowView(project: project, columns: columns)
                        Divider()
                    }
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    ProjectsTableView(projects: [
        .init(emoji: "📄", name: "Research study", status: "In Progress", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "📬", name: "Marketing cam", status: "In Progress", owner: "Sam", avatar: "person.crop.circle.fill"),
        .init(emoji: "🎨", name: "Website redesi", status: "Planning", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "🚀", name: "Product launch", status: "In Progress", owner: "Ben", avatar: "person.crop.circle.badge.checkmark")
    ])
}

