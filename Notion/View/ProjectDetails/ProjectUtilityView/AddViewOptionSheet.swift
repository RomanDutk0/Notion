import SwiftUI

struct AddViewOptionSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var selectedIcon: String = "square.grid.2x2"
    @State private var type: ViewType = .board
    @State private var selectedGroupByFieldID: UUID? = nil

    var availableFields: [FieldValue]
    var onAdd: (ViewOption) -> Void

    let iconOptions = ["square.grid.2x2", "list.bullet", "calendar", "tag", "folder", "person.crop.circle", "star", "flag"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic info")) {
                    TextField("View name", text: $title)

                    Picker("Icon", selection: $selectedIcon) {
                        ForEach(iconOptions, id: \.self) { icon in
                            HStack {
                                Image(systemName: icon)
                            }
                            .tag(icon)
                        }
                    }

                    Picker("View type", selection: $type) {
                        Text("Board").tag(ViewType.board)
                        Text("Table").tag(ViewType.table)
                    }
                }

                if type == .board {
                    Section(header: Text("Group by")) {
                        Picker("Field", selection: $selectedGroupByFieldID) {
                            ForEach(availableFields.filter { $0.field.type == .selection }, id: \.field.id) { fieldValue in
                                Text(fieldValue.field.name)
                                    .tag(fieldValue.field.id as UUID?)
                            }
                        }
                    }
                }
            }
            .onAppear {
                print("Available fields:")
                for fieldValue in availableFields {
                    print(" - \(fieldValue.field.name) [\(fieldValue.field.id)]")
                }
            }
            .navigationTitle("New view option")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }

                        let groupValue = type == .board
                            ? (availableFields.first { $0.field.id == selectedGroupByFieldID }?.field.name ?? "")
                            : ""

                        let newOption = ViewOption(
                            title: title,
                            icon: selectedIcon,
                            type: type,
                            groupByFieldName: groupValue
                        )
                        onAdd(newOption)
                        dismiss()
                    }
                }
            }
        }
    }
}

