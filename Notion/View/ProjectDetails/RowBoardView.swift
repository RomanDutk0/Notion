import SwiftUI
import SwiftUI

struct ProjectsTableView: View {
    
    @State var fields: [Field]
    @Binding var tasks: [Task]
 
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                VStack(spacing: 0) {
                    ScrollView(.vertical) {
                        HStack {
                            ForEach(fields) { field in
                                HStack(spacing: 4) {
                                    Text(field.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.gray)
                                    Button(action: {
                                        if let index = fields.firstIndex(where: { $0.id == field.id }) {
                                            fields.remove(at: index)
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .imageScale(.small)
                                            .opacity(0.3)
                                    }
                                }
                                .frame(width: 120, alignment: .leading)
                            }

                            Button(action: {
                                fields.append(Field(name: "New Field", type: .text))
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))

                        Divider()

                        ForEach($tasks) { $task in
                            RowView(task: $task,tasks: $tasks , fields: fields)
                            Divider()
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct ProjectsTableView_Previews: PreviewProvider {
    @State static var tasks: [Task] = [
        Task(fieldValues: [
            FieldValue(field: Field(name: "Name", type: .text), value: .text("🚀 Product Launch")),
            FieldValue(field: Field(name: "Status", type: .selection), value: .selection(["In Progress"])),
            FieldValue(field: Field(name: "End date", type: .date), value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))),
            FieldValue(field: Field(name: "Priority", type: .selection), value: .selection(["High"])),
            FieldValue(field: Field(name: "Start date", type: .date), value: .date(Date()))
        ]),
        Task(fieldValues: [
            FieldValue(field: Field(name: "Name", type: .text), value: .text("📝 Write Documentation")),
            FieldValue(field: Field(name: "Status", type: .selection), value: .selection(["Not Started"])),
            FieldValue(field: Field(name: "End date", type: .date), value: .date(Date().addingTimeInterval(60 * 60 * 24 * 10))),
            FieldValue(field: Field(name: "Priority", type: .selection), value: .selection(["Medium"])),
            FieldValue(field: Field(name: "Start date", type: .date), value: .date(Date()))
        ])
    ]

    static var previews: some View {
        ProjectsTableView(
            fields: [
                Field(name: "Name", type: .text),
                Field(name: "Status", type: .selection, options: ["In Progress", "Not Started"]),
                Field(name: "End date", type: .date),
                Field(name: "Priority", type: .selection, options: ["High", "Medium"]),
                Field(name: "Start date", type: .date)
            ],
            tasks: $tasks
        )
    }
}
