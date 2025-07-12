import SwiftUI

struct RowView: View {
    var task: Task
    var fields: [Field]

    @State private var showDetail = false
    
    var body: some View {
        Button{
            showDetail = true
        }label : {
            HStack {
                ForEach(fields) { field in
                    cellContent(for: field)
                        .frame(width: 120, alignment: .leading)
                }
            }
            .font(.title3)
            .frame(height: 60)
            .padding(.horizontal, 24)
            
        }.foregroundColor(.black)
        .sheet(isPresented: $showDetail) {
            TaskConstructorView(task: task)
        }
    }
        

    @ViewBuilder
    private func cellContent(for field: Field) -> some View {
        if let fieldValue = task.fieldValues.first(where: { $0.field.name == field.name }) {
            Text(stringValue(for: fieldValue.value))
        } else {
            Text("-")
        }
    }

    private func stringValue(for value: FieldDataValue) -> String {
        switch value {
        case .text(let str): return str
        case .number(let num): return String(num)
        case .boolean(let bool): return bool ? "✅" : "❌"
        case .date(let date): return dateFormatter.string(from: date)
        case .url(let urlStr): return urlStr
        case .selection(let selection): return selection
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    RowView(
        task: Task(fieldValues: [
            FieldValue(field: Field(name: "Name", type: .text), value: .text("🚀 Product Launch")),
            FieldValue(field: Field(name: "Status", type: .selection), value: .selection("In Progress")),
            FieldValue(field: Field(name: "End date", type: .date), value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))),
            FieldValue(field: Field(name: "Priority", type: .selection), value: .selection("High")),
            FieldValue(field: Field(name: "Start date", type: .date), value: .date(Date()))
        ]),
        fields: [
            Field(name: "Name", type: .text),
            Field(name: "Status", type: .selection),
            Field(name: "End date", type: .date),
            Field(name: "Priority", type: .selection),
            Field(name: "Start date", type: .date)
        ]
    )
}

