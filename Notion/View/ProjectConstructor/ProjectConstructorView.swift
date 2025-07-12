import SwiftUI



struct CardConstructorView: View {
    @State private var fields: [Field] = [
        Field(name: "Title", type: .text)
    ]
    
    @State private var showAddFieldSheet = false
    @State private var newFieldName = ""
    @State private var newFieldType: FieldType = .text
    @State private var newFieldOptions = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fields) { field in
                        VStack(alignment: .leading) {
                            Text(field.name)
                                .font(.headline)
                            Text("Type: \(field.type.rawValue)")
                                .font(.subheadline)
                            if field.type == .selection {
                                Text("Options: \(field.options.joined(separator: ", "))")
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    showAddFieldSheet = true
                }) {
                    Label("Add Field", systemImage: "plus")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: saveProject) {
                    Text("Save Project")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Card Constructor")
            .sheet(isPresented: $showAddFieldSheet) {
                addFieldSheet
            }
        }
    }
    
    var addFieldSheet: some View {
        NavigationView {
            Form {
                Section(header: Text("Field Name")) {
                    TextField("Enter name", text: $newFieldName)
                }
                
                Section(header: Text("Field Type")) {
                    Picker("Type", selection: $newFieldType) {
                        ForEach(FieldType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if newFieldType == .selection {
                    Section(header: Text("Options (comma separated)")) {
                        TextField("To Do, In Progress, Done", text: $newFieldOptions)
                    }
                }
            }
            .navigationTitle("New Field")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addField()
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
    
    private func addField() {
        var options: [String] = []
        if newFieldType == .selection {
            options = newFieldOptions
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { !$0.isEmpty }
        }
        let field = Field(name: newFieldName, type: newFieldType, options: options)
        fields.append(field)
        
        // Скинути стан
        newFieldName = ""
        newFieldOptions = ""
        newFieldType = .text
        showAddFieldSheet = false
    }
    
    private func saveProject() {
        // TODO: Зберегти в реальному проєкті
        print("Saving project with fields:")
        fields.forEach { print("- \($0.name): \($0.type.rawValue)") }
    }
}

// MARK: - Preview

struct CardConstructorView_Previews: PreviewProvider {
    static var previews: some View {
        CardConstructorView()
    }
}

