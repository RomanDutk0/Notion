import SwiftUI

struct CardView: View {
    var task: Task
    
    @State private var showDetail = false
    
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
        }
        .sheet(isPresented: $showDetail) {
           TaskConstructorView(task: task)
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
            CardViewModel.labeledRow(fieldValue.field.name, url)
        case .selection(let option):
            CardViewModel.labeledRow(fieldValue.field.name, option)
        }
    }
    
    
}

#Preview {
    let fields = [
        Field(name: "Name", type: .text),
        Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low"]),
        Field(name: "Due Date", type: .date)
    ]
    
    let task = Task(fieldValues: [
        FieldValue(field: fields[0], value: .text("🚀Product Launch")),
        FieldValue(field: fields[1], value: .selection("High")),
        FieldValue(field: fields[2], value: .date(Date()))
    ])
    
    return CardView(task: task)
}

