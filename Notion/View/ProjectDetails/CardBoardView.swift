import SwiftUI

struct CardBoard: View {
    
    @StateObject var cardModel  = CardViewModel()
    @StateObject var taskListModel :TaskListViewModel = TaskListViewModel()
    @Binding var tasks: [Task]
    @Binding   var selectedViewOption: ViewOption
    var fields: [Field]
    @Binding var hiddenFieldIDs: Set<UUID>
   
    
    var tasksByStatus: [String: [Task]] {
        Dictionary(grouping: tasks, by: { CardViewModel.status(for: $0 , field:selectedViewOption.groupByFieldName! ) })
    }

    var uniqueStatuses: [String] {
        Array(tasksByStatus.keys)
    }

 

    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            HStack(alignment: .top, spacing: 32) {
                ForEach(uniqueStatuses, id: \.self) { status in
                    
                        TaskCardView(
                            cardModel: cardModel, taskListModel: taskListModel,
                            cardStatus: status,
                            fields: fields,
                            allTasks:  $tasks ,
                            hiddenFieldIDs: $hiddenFieldIDs ,
                            selectedViewOption: $selectedViewOption
                        )
                }
            }
            .padding()
        }
    }
    private func bindingForTasks(withStatus status: String) -> Binding<[Task]> {
        Binding(
            get: {
                tasks.filter { CardViewModel.status(for: $0 , field: selectedViewOption.groupByFieldName!) == status }
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
    struct PreviewWrapper: View {
        @State var tasksState: [Task] = [
            Task(fieldValues: [
                FieldValue(field: PreviewWrapper.fields[0], value: .text("🚀")),
                FieldValue(field: PreviewWrapper.fields[1], value: .text("Product Launch")),
                FieldValue(field: PreviewWrapper.fields[2], value: .selection(["In Progress"])),
                FieldValue(field: PreviewWrapper.fields[3], value: .selection(["High"]))
            ]),
            Task(fieldValues: [
                FieldValue(field: PreviewWrapper.fields[0], value: .text("📝")),
                FieldValue(field: PreviewWrapper.fields[1], value: .text("Write Documentation")),
                FieldValue(field: PreviewWrapper.fields[2], value: .selection(["Not Started"])),
                FieldValue(field: PreviewWrapper.fields[3], value: .selection(["Medium"]))
            ]),
            Task(fieldValues: [
                FieldValue(field: PreviewWrapper.fields[0], value: .text("🎨")),
                FieldValue(field: PreviewWrapper.fields[1], value: .text("Design New Logo")),
                FieldValue(field: PreviewWrapper.fields[2], value: .selection(["Completed"])),
                FieldValue(field: PreviewWrapper.fields[3], value: .selection(["Low"]))
            ]),
            Task(fieldValues: [
                FieldValue(field: PreviewWrapper.fields[0], value: .text("📣")),
                FieldValue(field: PreviewWrapper.fields[1], value: .text("Marketing Campaign")),
                FieldValue(field: PreviewWrapper.fields[2], value: .selection(["Planning"])),
                FieldValue(field: PreviewWrapper.fields[3], value: .selection(["High"]))
            ]),
            Task(fieldValues: [
                FieldValue(field: PreviewWrapper.fields[0], value: .text("🔍")),
                FieldValue(field: PreviewWrapper.fields[1], value: .text("QA Testing")),
                FieldValue(field: PreviewWrapper.fields[2], value: .selection(["In Progress"])),
                FieldValue(field: PreviewWrapper.fields[3], value: .selection(["Critical"]))
            ])
        ]
        
        @State var hiddenFieldIDs: Set<UUID> = []
        @State var selectedViewOption = ViewOption(
            title: "By Status",
            icon: "arrow.right",
            type: .board,
            groupByFieldName: "Status"
        )
        
        static let fields = [
            Field(name: "Emoji", type: .text),
            Field(name: "Name", type: .text),
            Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Completed", "Planning"]),
            Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low", "Critical"])
        ]
        
        var body: some View {
            let cardModel = CardViewModel(task: $tasksState[0]) 

            CardBoard(
                cardModel: cardModel,
                tasks: $tasksState,
                selectedViewOption: $selectedViewOption,
                fields: Self.fields,
                hiddenFieldIDs: $hiddenFieldIDs
            )
        }
    }

    return PreviewWrapper()
}
