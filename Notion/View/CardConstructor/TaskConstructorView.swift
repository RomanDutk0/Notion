import SwiftUI

struct TaskConstructorView: View {
    @Binding var task: Task

    @State private var comment: String = ""
    @State private var subTasks: [SubTask] = [
        SubTask(title: "To do 1", isDone: true),
        SubTask(title: "To do 2", isDone: true),
        SubTask(title: "To do 3", isDone: true)
    ]

 

   
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack{
                    if let emoji = CardViewModel.getField(.text, named: "Emoji", task)?.asText {
                        Text(emoji)
                            .frame(width: 60, height: 60)
                            .font(.system(size: 60, weight: .bold))
                    }
                    
                    
                    if let name = CardViewModel.getField(.text, named: "Name", task)?.asText {
                        Text(name)
                            .font(.largeTitle)
                            .bold()
                    }
                }
                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    ForEach($task.fieldValues) { $fieldValue in
                        HStack {
                            Label(fieldValue.field.name, systemImage: "circle.fill")
                            Spacer()
                            fieldEditor(for: $fieldValue)
                        }
                    }
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

            }
            .padding()
        }
        .background(Color(.systemBackground))
    }

    
    @ViewBuilder
    private func fieldEditor(for fieldValue: Binding<FieldValue>) -> some View {
        switch fieldValue.wrappedValue.value {
        case .text(let text):
            TextField("", text: fieldValue.textBinding)
                .multilineTextAlignment(.trailing)

        case .number(let num):
            TextField("", value: fieldValue.numberBinding, formatter: NumberFormatter())
                .multilineTextAlignment(.trailing)

        case .selection(let selection):
            Menu {
                ForEach(fieldValue.wrappedValue.field.options, id: \.self) { option in
                    Button(option) {
                        fieldValue.wrappedValue.value = .selection(option)
                    }
                }
            } label: {
                Text(selection)
                    .foregroundColor(.gray)
            }

        case .date(let date):
            DatePicker("", selection: fieldValue.dateBinding, displayedComponents: [.date])
                .labelsHidden()

        case .boolean(let bool):
            Toggle("", isOn: fieldValue.booleanBinding)
                .labelsHidden()

        case .url(let url):
            TextField("", text: fieldValue.textBinding)
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
    var asSelection: String? {
        if case .selection(let s) = self { return s }
        return nil
    }
    var asDate: Date? {
        if case .date(let d) = self { return d }
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
    TaskConstructorView(task: .constant(
        Task(fieldValues: [
            FieldValue(field: Field(name: "Emoji", type: .text), value: .text("🚀")),
            FieldValue(field: Field(name: "Name", type: .text), value: .text("Product Launch")),
            FieldValue(field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]), value: .selection("In Progress")),
            FieldValue(field: Field(name: "Start Date", type: .date), value: .date(Date())),
            FieldValue(field: Field(name: "End Date", type: .date), value: .date(Date().addingTimeInterval(86400 * 30))),
            FieldValue(field: Field(name: "Public", type: .boolean), value: .boolean(true)),
            FieldValue(field: Field(name: "Website", type: .url), value: .url("https://example.com"))
        ])
    ))
}
