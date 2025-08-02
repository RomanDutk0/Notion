import SwiftUI

struct AddPropertyView: View {

  @State private var newFieldName: String = ""
  @State private var newFieldType: FieldType = .text
  @State private var newFieldOptions: String = ""

  @ObservedObject var cardModel: CardViewModel
  @Binding var task: Task
  @Binding var showAddFieldSheet: Bool

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Field Name")) {
          TextField("Enter name", text: $newFieldName)
        }

        Section(header: Text("Field Type")) {
          VStack(alignment: .leading, spacing: 8) {
            ForEach(FieldType.allCases) { type in
              HStack {
                Text(type.rawValue)
                  .foregroundColor(newFieldType == type ? .blue : .primary)
                Spacer()
                if newFieldType == type {
                  Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                }
              }
              .contentShape(Rectangle())
              .onTapGesture {
                newFieldType = type
              }
              Divider()
            }
          }
        }

        if newFieldType == .selection {
          Section(header: Text("Options (comma separated)")) {

            TextField("To Do, In Progress, Done", text: $newFieldOptions)
              .padding(.bottom, 30)

          }
          Button {
            print()
          } label: {
            Text("Add optoin")
              .bold()
              .frame(maxWidth: .infinity, alignment: .center)
          }
        }
      }
      .navigationTitle("New Field")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            cardModel.addFieldToCard(
              name: newFieldName,
              type: newFieldType,
              optionsString: newFieldOptions,
              fields: $task.fieldValues)

            showAddFieldSheet = false
          }.disabled(newFieldName.isEmpty)
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            showAddFieldSheet = false
          }
        }
      }
    }
  }
}

#Preview {
  struct AddPropertyPreviewWrapper: View {
    @State var showSheet = true
    @State var previewTask = Task(fieldValues: [
      FieldValue(
        field: Field(name: "Name", type: .text),
        value: .text("🚀 Product Launch")
      ),
      FieldValue(
        field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
        value: .selection(["In Progress"])
      ),
      FieldValue(
        field: Field(name: "End Date", type: .date),
        value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
      ),
    ])

    var body: some View {
      let cardModel = CardViewModel(task: $previewTask)

      return AddPropertyView(
        cardModel: cardModel,
        task: $previewTask,
        showAddFieldSheet: $showSheet

      )
    }
  }

  return AddPropertyPreviewWrapper()
}
