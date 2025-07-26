import SwiftUI

struct CardView: View {
    
    @Binding var task: Task
    @Binding var tasks: [Task]
    @State private var showDetail = false
    @State var currentDragging : Task?
    @Binding var hiddenFieldIDs: Set<UUID>
    
    var body: some View {
        Button {
            showDetail = true
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(task.fieldValues.filter { !hiddenFieldIDs.contains($0.field.id) }) { fieldValue in
                        fieldRow(fieldValue)
                    }
                           
                
            }
            .frame(width: 235)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            )
            .contentShape(.dragPreview , .rect(cornerRadius : 12))
        }
        .sheet(isPresented: $showDetail) {
            TaskConstructorView(
                task: $task,hiddenFieldIDs: $hiddenFieldIDs,
                onDelete: {
                    CardViewModel.deleteCard(&tasks, task)
                }
            )

        }
        .onDrag {
            return NSItemProvider(object: task.id.uuidString as NSString)
        }
    }
    }
    
   
    @ViewBuilder
    private func fieldRow(_ fieldValue: FieldValue) -> some View {
        switch fieldValue.value {
        case .text(let text):
            CardViewModel.labeledRow(fieldValue.field.name, text)
        case .number(let number):
            CardViewModel.labeledRow(fieldValue.field.name, String(number))
        case .boolean(let flag):
            CardViewModel.labeledRow(fieldValue.field.name, flag ? "✅" : "❌")
        case .date(let date):
            CardViewModel.labeledRow(fieldValue.field.name, CardViewModel.formatted(date))
        case .url(let url):
                URLPreview(urlString: url)
        case .selection(let option):
            CardViewModel.labeledRow(fieldValue.field.name, option.joined(separator: ", "))
        }
    }
    
    

#Preview {
    struct PreviewWrapper: View {
        @State var previewTasks: [Task] = [
            Task(fieldValues: [
                FieldValue(field: Field(name: "Name", type: .text), value: .text("🚀 Product Launch")),
                FieldValue(field: Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low"]), value: .selection(["High", "Urgent"])),
                FieldValue(field: Field(name: "Due Date", type: .date), value: .date(Date())),
                FieldValue(field: Field(name: "Website", type: .url), value: .url("https://example.com"))
            ])
        ]
        @State var hidden: Set<UUID> = []

        var body: some View {
            CardView(
                task: $previewTasks[0],
                tasks: $previewTasks,
                hiddenFieldIDs: $hidden
            )
        }
    }

    return PreviewWrapper()
}
