import SwiftUI

struct RowView: View {
    
    @Binding var task: Task
    @Binding var tasks: [Task]
    var fields: [Field]
    @State private var showDetail = false
    @Binding var hiddenFieldIDs: Set<UUID>
    let columnWidth: CGFloat

    var body: some View {
        Button {
            showDetail = true
        } label: {
            HStack(spacing: 0) {
                let visibleFields = fields.filter { !hiddenFieldIDs.contains($0.id) }
                ForEach(Array(visibleFields.enumerated()), id: \.element.id) { index, field in
                    cellContent(for: field)
                        .frame(width: columnWidth, alignment: .center) // Центрування значення

                    if index < visibleFields.count - 1 {
                        Divider()
                            .frame(height: 40)
                    }
                }
            }
            .font(.title3)
            .frame(height: 60)
            .padding(.horizontal, 24)
        }
        .foregroundColor(.black)
        .sheet(isPresented: $showDetail) {
            TaskConstructorView(
                task: $task,
                hiddenFieldIDs: $hiddenFieldIDs,
                onDelete: {
                    CardViewModel.deleteCard(&tasks, task)
                }
            )
        }
    }

    @ViewBuilder
    private func cellContent(for field: Field) -> some View {
        if let fieldValue = task.fieldValues.first(where: { $0.field.name == field.name }) {
            Text(CardViewModel.stringValue(for: fieldValue.value))
                .multilineTextAlignment(.center) // Центрування тексту
        } else {
            Text("-")
                .multilineTextAlignment(.center) // Центрування навіть якщо значення немає
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}


#Preview {
    struct RowViewPreviewWrapper: View {
        @State var tasks: [Task] = [
            Task(fieldValues: [
                FieldValue(
                    field: Field(name: "Name", type: .text),
                    value: .text("🚀 Product Launch")
                ),
                FieldValue(
                    field: Field(name: "Status", type: .selection),
                    value: .selection(["In Progress"])
                ),
                FieldValue(
                    field: Field(name: "End date", type: .date),
                    value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                ),
                FieldValue(
                    field: Field(name: "Priority", type: .selection),
                    value: .selection(["High"])
                ),
                FieldValue(
                    field: Field(name: "Start date", type: .date),
                    value: .date(Date())
                )
            ])
        ]
        
        @State var hiddenFieldIDs: Set<UUID> = []
        
        var body: some View {
            RowView(
                task: $tasks[0],
                tasks: $tasks,
                fields: [
                    Field(name: "Name", type: .text),
                    Field(name: "Status", type: .selection),
                    Field(name: "End date", type: .date),
                    Field(name: "Priority", type: .selection),
                    Field(name: "Start date", type: .date)
                ],
                hiddenFieldIDs: $hiddenFieldIDs,
                columnWidth: 140
            )
        }
    }
    
    return RowViewPreviewWrapper()
}
