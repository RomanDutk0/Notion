import SwiftUI

struct CardView: View {
    
    @ObservedObject var cardModel : CardViewModel
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
                    cardModel.fieldRow(fieldValue)
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
                cardModel: cardModel,
                task: $task,
                hiddenFieldIDs: $hiddenFieldIDs,
                onDelete: {
                   cardModel.deleteCard(&tasks, task)
                }
            )

        }
        .onDrag {
            return NSItemProvider(object: task.id.uuidString as NSString)
        }
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
        @State var cardModel : CardViewModel = CardViewModel()
        var body: some View {
            CardView(
                cardModel: cardModel,
                task: $previewTasks[0],
                tasks: $previewTasks,
                hiddenFieldIDs: $hidden
            )
        }
    }

    return PreviewWrapper()
}
