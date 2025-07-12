import SwiftUI

struct CardBoard: View {
    var tasks: [Task]
    var fields: [Field]

   
    private func status(for task: Task) -> String {
        if let statusField = task.fieldValues.first(where: { $0.field.name == "Status" }) {
            if case let .selection(value) = statusField.value {
                return value
            }
        }
        return "Unknown"
    }

   
    var tasksByStatus: [String: [Task]] {
        Dictionary(grouping: tasks, by: { status(for: $0) })
    }

    var uniqueStatuses: [String] {
        Array(tasksByStatus.keys)
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 32) {
                ForEach(uniqueStatuses, id: \.self) { status in
                    if let groupedTasks = tasksByStatus[status] {
                        TaskCardView(
                            cardStatus: status,
                            tasks: groupedTasks,
                            fields: fields // Передаємо шаблон полів!
                        )
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let fields = [
        Field(name: "Emoji", type: .text),
        Field(name: "Name", type: .text),
        Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Completed", "Planning"]),
        Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low", "Critical"])
    ]
    
    let tasks = [
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🚀")),
            FieldValue(field: fields[1], value: .text("Product Launch")),
            FieldValue(field: fields[2], value: .selection("In Progress")),
            FieldValue(field: fields[3], value: .selection("High"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("📝")),
            FieldValue(field: fields[1], value: .text("Write Documentation")),
            FieldValue(field: fields[2], value: .selection("Not Started")),
            FieldValue(field: fields[3], value: .selection("Medium"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🎨")),
            FieldValue(field: fields[1], value: .text("Design New Logo")),
            FieldValue(field: fields[2], value: .selection("Completed")),
            FieldValue(field: fields[3], value: .selection("Low"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("📣")),
            FieldValue(field: fields[1], value: .text("Marketing Campaign")),
            FieldValue(field: fields[2], value: .selection("Planning")),
            FieldValue(field: fields[3], value: .selection("High"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🔍")),
            FieldValue(field: fields[1], value: .text("QA Testing")),
            FieldValue(field: fields[2], value: .selection("In Progress")),
            FieldValue(field: fields[3], value: .selection("Critical"))
        ])
    ]

    return CardBoard(tasks: tasks, fields: fields)
}

