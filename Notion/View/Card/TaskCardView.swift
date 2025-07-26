import SwiftUI
import UniformTypeIdentifiers


struct TaskCardView: View {
    
    @ObservedObject var projectModel = ProjectViewModel.getInstance()
    let cardStatus: String
    var fields: [Field]
    @Binding var allTasks: [Task]
    @Binding var hiddenFieldIDs: Set<UUID>
    var body: some View {
        let filteredTasks = allTasks.filter { CardViewModel.status(for: $0) == cardStatus }

        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(cardStatus)
                    .bold()
                Spacer()
                Text("\(filteredTasks.count)").opacity(0.5)
            }

            ForEach(filteredTasks) { task in
                CardView(
                    task: Binding(
                        get: { task },
                        set: { updated in
                            if let i = allTasks.firstIndex(where: { $0.id == updated.id }) {
                                allTasks[i] = updated
                            }
                        }
                    ),
                    tasks: $allTasks,
                    hiddenFieldIDs: $hiddenFieldIDs
                )
            }


            Button {
                if let template = projectModel.template(forTask: allTasks.first) {
                                   addTask(template: template)
                               } else {
                                   print("❌ Could not find template")
                               }
            } label: {
                Label("New Task", systemImage: "plus")
                    .padding()
                    .frame(maxWidth:.infinity)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(width: 300)
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
        .onDrop(of: [.text], isTargeted: nil) { providers in
            providers.first?.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { data, _ in
                if let data = data as? Data,
                   let idString = String(data: data, encoding: .utf8),
                   let uuid = UUID(uuidString: idString) {
                    DispatchQueue.main.async {
                        moveTask(with: uuid)
                    }
                }
            }
            return true
        }
    }

    private func addTask(template : [FieldValue]) {
        
        allTasks.append(Task(fieldValues: template))
    }

    private func moveTask(with id: UUID) {
        if let index = allTasks.firstIndex(where: { $0.id == id }) {
            var updatedTask = allTasks[index]
            if let statusIndex = updatedTask.fieldValues.firstIndex(where: { $0.field.name == "Status" }) {
                updatedTask.fieldValues[statusIndex].value = .selection([cardStatus]) 
            }
            allTasks[index] = updatedTask
        }
    }
}


struct KanbanBoardPreview: View {
    @State private var allTasks: [Task] = [
        Task(fieldValues: [
            FieldValue(field: Field(name: "Name", type: .text), value: .text("Design UI")),
            FieldValue(field: Field(name: "Status", type: .selection, options: ["To Do", "In Progress", "Done"]), value: .selection( ["To Do"]))
        ])
    ]

    let fields: [Field] = [
        Field(name: "Name", type: .text),
        Field(name: "Status", type: .selection, options: ["To Do", "In Progress", "Done"])
    ]

    var body: some View {
        HStack(spacing: 20) {
           // TaskCardView(cardStatus: "To Do", fields: fields, allTasks: $allTasks, hiddenFieldIDs: )
         //   TaskCardView(cardStatus: "In Progress", fields: fields, allTasks: $allTasks)
          //  TaskCardView(cardStatus: "Done", fields: fields, allTasks: $allTasks)
        }
        .padding()
    }
}

#Preview {
    KanbanBoardPreview()
}

