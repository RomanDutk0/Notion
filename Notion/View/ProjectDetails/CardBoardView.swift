
//
//  CardBoardView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

import SwiftUI

struct CardBoard: View {
    var projects: [Project]

    var projectsByStatus: [String: [Project]] {
        Dictionary(grouping: projects, by: { $0.status })
    }

    var uniqueStatuses: [String] {
        Array(projectsByStatus.keys)
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 32) {
                ForEach(uniqueStatuses, id: \.self) { status in
                    if let projects = projectsByStatus[status] {
                        TaskCardView( 
                            cardStatus: status,
                            projects: projects
                        )
                    }
                }
            }
            .padding()
        }
    }
}




#Preview {
    CardBoard(projects: [
        .init(emoji: "📄", name: "Research study", status: "In Progress", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "📬", name: "Marketing cam", status: "In Progress", owner: "Sam", avatar: "person.crop.circle.fill"),
        .init(emoji: "🎨", name: "Website redesi", status: "Planning", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "🚀", name: "Product launch", status: "In Progress", owner: "Ben", avatar: "person.crop.circle.badge.checkmark")
    ])
}
