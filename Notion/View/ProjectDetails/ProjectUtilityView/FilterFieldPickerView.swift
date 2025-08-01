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
                            TextField("Enter text", text: Binding(
                                get: {
                                    if case .text(let value) = localValues[field.id] {
                                        return value
                                    }
                                    return ""
                                },
                                set: { newValue in
                                    localValues[field.id] = .text(newValue)
                                }
                            ))

                        case .number:
                            TextField("Enter number", text: Binding(
                                get: {
                                    if case .number(let value) = localValues[field.id] {
                                        return String(value)
                                    }
                                    return ""
                                },
                                set: { newValue in
                                    if let number = Double(newValue) {
                                        localValues[field.id] = .number(number)
                                    }
                                }
                            ))
                            .keyboardType(.decimalPad)

                        case .date:
                            DatePicker("Select date", selection: Binding(
                                get: {
                                    if case .date(let date) = localValues[field.id] {
                                        return date
                                    }
                                    return Date()
                                },
                                set: { newDate in
                                    localValues[field.id] = .date(newDate)
                                }
                            ), displayedComponents: [.date])

                        case .boolean:
                            Toggle("Enabled", isOn: Binding(
                                get: {
                                    if case .boolean(let flag) = localValues[field.id] {
                                        return flag
                                    }
                                    return false
                                },
                                set: { newValue in
                                    localValues[field.id] = .boolean(newValue)
                                }
                            ))

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

