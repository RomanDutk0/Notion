//
//  RowView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct Column: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var width: CGFloat
}


struct RowView: View {
    var project: Project
    var columns: [Column]

    var body: some View {
        HStack {
            ForEach(columns) { column in
                cellContent(for: column)
                    .frame(width: column.width, alignment: .leading)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func cellContent(for column: Column) -> some View {
        switch column.title {
        case "Project name":
            Text("\(project.emoji) \(project.name)")
        case "Status":
            Text(project.status)
                .foregroundColor(.white)
                .padding(4)
                //.background(project.status)
                .cornerRadius(4)
        case "End date":
            Text("N/A") // Поки немає дати — заглушка
        case "Priority":
            Text("N/A")
        case "Start date":
            Text("N/A")
        default:
            Text("-")
        }
    }
}
#Preview {
    RowView(
        project: Project(
            emoji: "🚀",
            name: "Product Launch",
            status:  "dhrte",
            owner: "Ben",
            avatar: "person.crop.circle"
        ),
        columns: [
            Column(title: "Project name", width: 200),
            Column(title: "Status", width: 120),
            Column(title: "End date", width: 120),
            Column(title: "Priority", width: 120),
            Column(title: "Start date", width: 120)
        ]
    )
}

