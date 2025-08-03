import SwiftUI

struct TaskConstructorView: View {
    
    @ObservedObject var cardModel : CardViewModel
    @Binding var task: Task
    @State private var comment: String = ""
    
    @State private var subTasks: [SubTask] = [
        SubTask(title: "To do 1", isDone: true),
        SubTask(title: "To do 2", isDone: true),
        SubTask(title: "To do 3", isDone: true)
    ]
    @State private var showAddFieldSheet = false
    @Binding var hiddenFieldIDs: Set<UUID>
    @State private var showFieldVisibilitySheet = false
    
    var onDelete: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        if let emoji = cardModel.getField(.text, named: "Emoji", task)?.asText {
                            Text(emoji)
                                .frame(width: 60, height: 60)
                                .font(.system(size: 60, weight: .bold))
                        }
                        
                        if let name = cardModel.getField(.text, named: "Name", task)?.asText {
                            Text(name)
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                    
                    Divider()
                    
                    ForEach($task.fieldValues) { $fieldValue in
                      
                            HStack {
                                Label(fieldValue.field.name, systemImage: "circle.fill")
                                Spacer()
                                fieldEditor(for: $fieldValue)
                    
                        }
                    }
                    
                    
                    Button {
                        showAddFieldSheet = true
                    } label: {
                        Text("Add property")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        showFieldVisibilitySheet = true
                    } label: {
                        Text("Hide / Show Fields")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Comments")
                            .font(.headline)
                        TextField("Add a comment...", text: $comment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Sub-tasks")
                            .font(.headline)
                        ForEach($subTasks) { $task in
                            HStack {
                                Image(systemName: task.isDone ? "checkmark.square" : "square")
                                    .onTapGesture {
                                        task.isDone.toggle()
                                    }
                                Text(task.title)
                                    .strikethrough(task.isDone)
                                    .foregroundColor(task.isDone ? .gray : .primary)
                            }
                        }
                    }
                    
                    Divider()
                    
                    
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Label("Delete Task", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .sheet(isPresented: $showAddFieldSheet) {
                AddPropertyView(
                    task: $task,
                    showAddFieldSheet: $showAddFieldSheet
                )
            }.sheet(isPresented: $showFieldVisibilitySheet) {
                FieldVisibilityView(
                    fields: task.fieldValues.map { $0.field },
                    hiddenFieldIDs: $hiddenFieldIDs
                )
            }
        }
    }


    @ViewBuilder
    private func fieldEditor(for fieldValue: Binding<FieldValue>) -> some View {
        switch fieldValue.wrappedValue.value {
        case .text:
            TextField("", text: fieldValue.textBinding)
                .padding(.horizontal , 10)
                .multilineTextAlignment(.trailing)
        case .number:
            TextField("", value: fieldValue.numberBinding, formatter: NumberFormatter())
                .padding(.horizontal , 10)
                .multilineTextAlignment(.trailing)
        case .selection(let selectionArray):
            Menu {
                ForEach(fieldValue.wrappedValue.field.options ?? [], id: \.self) { option in
                    Button(option) {
                        fieldValue.wrappedValue.value = .selection([option])
                    }
                }
            } label: {
                Text(selectionArray.joined(separator: ", "))
                    .foregroundColor(.gray)
            } .padding(.horizontal , 10)
        case .date:
            DatePicker("", selection: fieldValue.dateBinding, displayedComponents: [.date])
                .padding(.horizontal , 10)
                .labelsHidden()
        case .boolean:
            Toggle("", isOn: fieldValue.booleanBinding)
                .padding(.horizontal , 10)
                .labelsHidden()
        case .url:
            TextField("", text: fieldValue.textBinding)
                .padding(.horizontal , 10)
                .keyboardType(.URL)
                .multilineTextAlignment(.trailing)
        }
    }
}



private extension FieldDataValue {
    var asText: String? {
        if case .text(let t) = self { return t }
        return nil
    }
}

extension Binding where Value == FieldValue {
    var textBinding: Binding<String> {
        Binding<String>(
            get: {
                if case .text(let t) = wrappedValue.value { return t }
                if case .url(let u) = wrappedValue.value { return u }
                return ""
            },
            set: { newValue in
                switch wrappedValue.value {
                case .text:
                    wrappedValue.value = .text(newValue)
                case .url:
                    wrappedValue.value = .url(newValue)
                default: break
                }
            }
        )
    }

    var numberBinding: Binding<Double> {
        Binding<Double>(
            get: {
                if case .number(let n) = wrappedValue.value { return n }
                return 0
            },
            set: { newValue in
                wrappedValue.value = .number(newValue)
            }
        )
    }

    var dateBinding: Binding<Date> {
        Binding<Date>(
            get: {
                if case .date(let d) = wrappedValue.value { return d }
                return Date()
            },
            set: { newValue in
                wrappedValue.value = .date(newValue)
            }
        )
    }

    var booleanBinding: Binding<Bool> {
        Binding<Bool>(
            get: {
                if case .boolean(let b) = wrappedValue.value { return b }
                return false
            },
            set: { newValue in
                wrappedValue.value = .boolean(newValue)
            }
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var sampleTask = Task(fieldValues: [
            FieldValue(field: Field(name: "Emoji", type: .text), value: .text("🚀")),
            FieldValue(field: Field(name: "Name", type: .text), value: .text("Product Launch")),
            FieldValue(field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]), value: .selection(["In Progress"]))
        ])
        
        @State var hiddenFields: Set<UUID> = []

        var body: some View {
         
            let cardModel = CardViewModel(task: $sampleTask)

            TaskConstructorView(
                cardModel: cardModel,
                task: $sampleTask,
                hiddenFieldIDs: $hiddenFields,
                onDelete: {
                    print("Deleted Task")
                }
            )
        }
    }

    return PreviewWrapper()
}
