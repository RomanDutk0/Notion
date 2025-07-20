import SwiftUI

struct CardBoard: View {
    @Binding var tasks: [Task]
    var fields: [Field]

   
    var tasksByStatus: [String: [Task]] {
        Dictionary(grouping: tasks, by: { CardViewModel.status(for: $0) })
    }

    var uniqueStatuses: [String] {
        Array(tasksByStatus.keys)
    }

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            HStack(alignment: .top, spacing: 32) {
                ForEach(uniqueStatuses, id: \.self) { status in
                        TaskCardView(
                            cardStatus: status,
                            tasks: bindingForTasks(withStatus: status),
                            fields: fields, allTasks:  $tasks
                        )
                }
            }
            .padding()
        }
    }
    private func bindingForTasks(withStatus status: String) -> Binding<[Task]> {
        Binding(
            get: {
                tasks.filter { CardViewModel.status(for: $0) == status }
            },
            set: { newTasks in
                for task in newTasks {
                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                        tasks[index] = task
                    }
                }
            }
        )
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
    
    @State var tasksState = tasks
    
    return CardBoard(tasks: $tasksState, fields: fields)
}
