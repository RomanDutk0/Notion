import SwiftUI

struct FilterFieldPickerView: View {

  let fields: [Field]
  @Binding var selectedFilterValues: [UUID: [String]]
  @Binding var isPresented: Bool

  var body: some View {
    NavigationView {
      Form {
        ForEach(fields) { field in
          Section(header: Text(field.name)) {
            if field.type == .selection, !field.options.isEmpty {
              ForEach(field.options, id: \.self) { option in
                let isSelected = selectedFilterValues[field.id, default: []].contains(option)

                Button(action: {
                  toggleOption(option, for: field.id)
                }) {
                  HStack {
                    Text(option)
                    Spacer()
                    if isSelected {
                      Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                    }
                  }
                }
              }
            } else {
              Text("Тільки селектори підтримуються")
                .foregroundColor(.gray)
            }
          }
        }
      }
      .navigationTitle("Фільтри")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Скасувати") {
            isPresented = false
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Готово") {
            isPresented = false
          }
        }
      }
    }
  }

  private func toggleOption(_ option: String, for fieldID: UUID) {
    if selectedFilterValues[fieldID, default: []].contains(option) {
      selectedFilterValues[fieldID]?.removeAll(where: { $0 == option })
      if selectedFilterValues[fieldID]?.isEmpty == true {
        selectedFilterValues.removeValue(forKey: fieldID)
      }
    } else {
      selectedFilterValues[fieldID, default: []].append(option)
    }
  }
}
