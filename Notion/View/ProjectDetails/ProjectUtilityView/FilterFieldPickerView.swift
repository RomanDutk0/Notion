import SwiftUI

struct FilterFieldPickerView: View {
  let fields: [Field]
  @Binding var isPresented: Bool
  @Binding var selectedFilterValues: [UUID: FieldDataValue]

  @State private var localValues: [UUID: FieldDataValue] = [:]

  var body: some View {
    NavigationView {
      Form {
        ForEach(fields) { field in
          Section(header: Text(field.name)) {
            switch field.type {
            case .selection:
              ForEach(field.options, id: \.self) { option in
                let selected = {
                  if case let .selection(selections) = localValues[field.id] {
                    return selections.contains(option)
                  }
                  return false
                }()

                Button(action: {
                  toggleSelection(option, for: field.id)
                }) {
                  HStack {
                    Text(option)
                    Spacer()
                    if selected {
                      Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                    }
                  }
                }
              }

            case .text:
              let isActive = localValues[field.id] != nil
              let textValue: String = {
                if case .text(let value) = localValues[field.id] {
                  return value
                }
                return ""
              }()

              Button(action: {
                if isActive {
                  localValues.removeValue(forKey: field.id)
                } else {
                  localValues[field.id] = .text("")
                }
              }) {
                HStack {
                  VStack(alignment: .leading, spacing: 4) {
                    Text("Enter text")
                      .font(.subheadline)
                      .foregroundColor(.primary)

                    if isActive {
                      TextField(
                        "Text",
                        text: Binding(
                          get: { textValue },
                          set: { newValue in
                            localValues[field.id] = .text(newValue)
                          }
                        )
                      )
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                      Text("Not applied")
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                  }

                  Spacer()

                  Image(systemName: isActive ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isActive ? .blue : .gray)
                }
              }

            case .number:
              let isActive = localValues[field.id] != nil
              let numberText: String = {
                if case .number(let value) = localValues[field.id] {
                  return String(value)
                }
                return ""
              }()

              Button(action: {
                if isActive {
                  localValues.removeValue(forKey: field.id)
                } else {
                  localValues[field.id] = .number(0)
                }
              }) {
                HStack {
                  VStack(alignment: .leading, spacing: 4) {
                    Text("Enter number")
                      .font(.subheadline)
                      .foregroundColor(.primary)

                    if isActive {
                      TextField(
                        "Number",
                        text: Binding(
                          get: { numberText },
                          set: { newValue in
                            if let number = Double(newValue) {
                              localValues[field.id] = .number(number)
                            }
                          }
                        )
                      )
                      .keyboardType(.decimalPad)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                      Text("Not applied")
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                  }

                  Spacer()

                  Image(systemName: isActive ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isActive ? .blue : .gray)
                }
              }

            case .date:
              let isActive = localValues[field.id] != nil
              let dateValue: Date = {
                if case .date(let date) = localValues[field.id] {
                  return date
                }
                return Date()
              }()

              Button(action: {
                if isActive {
                  localValues.removeValue(forKey: field.id)
                } else {
                  localValues[field.id] = .date(Date())
                }
              }) {
                HStack {
                  VStack(alignment: .leading, spacing: 4) {
                    Text("Select date")
                      .font(.subheadline)
                      .foregroundColor(.primary)

                    if isActive {
                      DatePicker(
                        "",
                        selection: Binding(
                          get: { dateValue },
                          set: { newDate in
                            localValues[field.id] = .date(newDate)
                          }
                        ), displayedComponents: [.date]
                      )
                      .labelsHidden()
                    } else {
                      Text("Not applied")
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                  }

                  Spacer()

                  if isActive {
                    Image(systemName: "checkmark.circle.fill")
                      .foregroundColor(.blue)
                  } else {
                    Image(systemName: "circle")
                      .foregroundColor(.gray)
                  }
                }
              }

            case .boolean:
              let isActive = localValues[field.id] != nil
              let boolValue: Bool = {
                if case .boolean(let flag) = localValues[field.id] {
                  return flag
                }
                return false
              }()

              Button(action: {
                if isActive {
                  localValues.removeValue(forKey: field.id)
                } else {
                  localValues[field.id] = .boolean(false)
                }
              }) {
                HStack {
                  VStack(alignment: .leading, spacing: 4) {
                    Text("Boolean toggle")
                      .font(.subheadline)
                      .foregroundColor(.primary)

                    if isActive {
                      Toggle(
                        "Enabled",
                        isOn: Binding(
                          get: { boolValue },
                          set: { newValue in
                            localValues[field.id] = .boolean(newValue)
                          }
                        )
                      )
                      .labelsHidden()
                    } else {
                      Text("Not applied")
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                  }

                  Spacer()

                  Image(systemName: isActive ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isActive ? .blue : .gray)
                }
              }

            default:
              Text("Unsupported type")
                .foregroundColor(.gray)
            }
          }
        }
      }
      .navigationTitle("Filters")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            isPresented = false
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            selectedFilterValues = localValues
            isPresented = false
          }
        }
      }
      .onAppear {
        localValues = selectedFilterValues
      }
    }
  }

  private func toggleSelection(_ option: String, for fieldID: UUID) {
    var selections: [String] = []

    if case let .selection(existing) = localValues[fieldID] {
      selections = existing
    }

    if selections.contains(option) {
      selections.removeAll { $0 == option }
    } else {
      selections.append(option)
    }

    if selections.isEmpty {
      localValues.removeValue(forKey: fieldID)
    } else {
      localValues[fieldID] = .selection(selections)
    }
  }

}
