//
//  TaskCardView.swift
//  Notion
//
//  Created by Roman on 03.07.2025.
//
import SwiftUI

struct TaskCardView: View {
    var cardStatus: String = ""
    var projects: [Project] = []

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                    Text(cardStatus)
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)

                Text("\(projects.count)")
                    .opacity(0.5)

                Spacer()

                Button {
                    print("More tapped")
                } label: {
                    Image(systemName: "ellipsis")
                        .opacity(0.3)
                        .padding()
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(width: 15, height: 15)

                Button {
                    print("Add tapped")
                } label: {
                    Image(systemName: "plus")
                        .opacity(0.3)
                        .padding()
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(width: 15, height: 15)
                .padding(.leading, 10)
            }
            .padding(.horizontal)

            // ⏺ Тепер рендеримо всі проекти у цьому статусі
            ForEach(projects) { project in
                CardView( emoji: project.emoji,
                    mainTitle: project.name,
                    cardPriority: "Priority", // Якщо є — project.priority
                    cardTaskType: "TaskType"  // Якщо є — project.taskType
                )
            }

            Button {
                print("New task tapped")
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New task")
                    Spacer()
                }
                .frame(width: 235, height: 15)
                .opacity(0.3)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(9)
                .foregroundColor(.black)
                .font(.headline)
            }
        }
        .padding(15)
        .frame(width: 290)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
    }
}


#Preview {
    TaskCardView()
}
