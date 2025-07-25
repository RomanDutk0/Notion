import SwiftUI

struct CardConstructorView: View {
    
    @Binding var projects: [Project]
    @State private var fields: [Field] = [
        Field(name: "Title", type: .text)
    ]
    @State private var projectName : String = "New Project"
    @State private var projectIcon : String = "📌"
    @State private var showAddFieldSheet = false
    @State private var newFieldName: String = ""
    @State private var newFieldType: FieldType = .text
    @State private var newFieldOptions : String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    
                    HStack(spacing: 12) {
                        Group {
                            if isEditing {
                                TextField("", text: $projectIcon, onCommit: { isEditing = false })
                                    .frame(width: 60, alignment: .center)
                                    .multilineTextAlignment(.center)
                            } else {
                                Text(projectIcon)
                                    .frame(width: 60, alignment: .center)
                            }
                        }
                        .font(.system(size: 50))
                        
                        Group {
                            if isEditing {
                                TextField("", text: $projectName, onCommit: { isEditing = false })
                                    .frame(minWidth: 200, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            } else {
                                Text(projectName)
                                    .bold()
                                    .frame(minWidth: 200, alignment: .leading)
                            }
                        }
                        .font(.system(size: 34, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        withAnimation {
                            isEditing = true
                        }
                    }
                    .padding()
                    
                }
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
                
                Button {
                    ProjectViewModel.saveProject(projects: &projects, fields: fields, projectIcon: projectIcon, projectName: projectName)
                }label: {
                    Text("Save Project")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("")
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
                        ProjectViewModel.addField(name: newFieldName, type: newFieldType, optionsString: newFieldOptions, fields: &fields)
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
    
    
struct CardConstructorView_Previews: PreviewProvider {
    @State static var previewProjects: [Project] = []

    static var previews: some View {
        CardConstructorView(projects: $previewProjects)
    }
}

