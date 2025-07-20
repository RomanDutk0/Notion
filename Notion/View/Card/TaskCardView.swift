import SwiftUI
import UniformTypeIdentifiers



struct TaskCardView: View {
    let cardStatus: String
    @Binding var tasks: [Task]
    var fields: [Field]
    @Binding var allTasks: [Task]

    var body: some View {
        VStack {
            HStack {
                Text(cardStatus)
                    .font(.headline)
                Spacer()
                Text("\(tasks.count)").opacity(0.5)
            }
            .padding(.horizontal)

            ForEach($tasks) { task in
                CardView(task: task)
            }

            Button {
                print("Add task tapped")
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New Task")
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .frame(width: 290)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
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

    private func moveTask(with id: UUID) {
        if let index = allTasks.firstIndex(where: { $0.id == id }) {
            var updatedTask = allTasks[index]

            if let statusIndex = updatedTask.fieldValues.firstIndex(where: { $0.field.name == "Status" }) {
                updatedTask.fieldValues[statusIndex].value = .selection(cardStatus)
            }

            allTasks[index] = updatedTask
        }
    }

}

