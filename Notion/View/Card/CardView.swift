import SwiftUI

struct CardView: View {
    @Binding var task: Task
    
    @State private var showDetail = false
    
    @State var currentDragging : Task?
    var body: some View {
        Button {
            showDetail = true
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(task.fieldValues) { fieldValue in
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
            TaskConstructorView(task: $task)
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
            CardViewModel.labeledRow(fieldValue.field.name, option)
        }
    }
    
    


#Preview {
    let fields = [
        Field(name: "Name", type: .text),
        Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low"]),
        Field(name: "Due Date", type: .date),
        Field(name: "Website", type: .url)
    ]

    return CardView(task: .constant(
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🚀 Product Launch")),
            FieldValue(field: fields[1], value: .selection("High")),
            FieldValue(field: fields[2], value: .date(Date())),
            FieldValue(field: fields[3], value: .url("https://www.youtube.com/watch?v=dQw4w9WgXcQ"))
        ])
    ))
}
