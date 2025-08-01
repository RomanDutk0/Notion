import SwiftUI

struct RowView: View {
    @ObservedObject var cardModel: CardViewModel
    @Binding var task: Task
    @Binding var tasks: [Task]
    var fields: [Field]
    @Binding var hiddenFieldIDs: Set<UUID>
    let columnWidth: CGFloat
    @State private var showDetail = false

    var body: some View {
        Button {
            showDetail = true
        } label: {
            HStack(spacing: 0) {
                let visibleFields = fields.filter { !hiddenFieldIDs.contains($0.id) }

                ForEach(Array(visibleFields.enumerated()), id: \.element.id) { index, field in
                    cellContent(for: field)
                        .frame(width: columnWidth, height: 50)
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )

                    if index < visibleFields.count - 1 {
                        Divider()
                            .frame(height: 40)
                            .background(Color.gray.opacity(0.3))
                    }
                }
            }
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
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
    }

    @ViewBuilder
    private func cellContent(for field: Field) -> some View {
        if let fieldValue = task.fieldValues.first(where: { $0.field.name == field.name }) {
            switch fieldValue.value {
            case .text(let text):
                Text(text)
                    .font(.body)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

            case .selection(let options):
                if let option = options.first {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                        Text(option)
                            .font(.footnote)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(Color.blue)
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("-")
                        .foregroundColor(.gray)
                }

            default:
                Text(CardViewModel.stringValue(for: fieldValue.value))
                    .lineLimit(1)
                    .foregroundColor(.black)
            }
        } else {
            Text("-")
                .foregroundColor(.gray)
        }
    }
}
