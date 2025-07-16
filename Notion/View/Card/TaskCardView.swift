import SwiftUI

struct TaskCardView: View {
    var cardStatus: String = ""
    
    @State var tasks: [Task]
    var fields: [Field]

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                    Text(cardStatus)
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)

                Text("\(tasks.count)")
                    .opacity(0.5)

                Spacer()

                Button {
                    print("More tapped")
                } label: {
                    Image(systemName: "ellipsis")
                        .opacity(0.3)
                        .padding()
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(width: 15, height: 15)

                Button {
                    CardViewModel.addTask(fields: fields, tasks: &tasks)
                } label: {
                    Image(systemName: "plus")
                        .opacity(0.3)
                        .padding()
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(width: 15, height: 15)
                .padding(.leading, 10)
            }
            .padding(.horizontal)

            ForEach(tasks) { task in
                CardView(task: task)
            }

            Button {
                CardViewModel.addTask(fields: fields, tasks: &tasks)
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("New task")
                    Spacer()
                }
                .frame(width: 235, height: 15)
                .opacity(0.3)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(9)
                .foregroundColor(.black)
                .font(.headline)
            }
        }
        .padding(15)
        .frame(width: 290)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
    }
    
}


#Preview {
    TaskCardView(
        cardStatus: "In Progress",
        tasks: [
            Task(fieldValues: [
                FieldValue(
                    field: Field(name: "Name", type: .text),
                    value: .text("🚀 Product Launch")
                ),
                FieldValue(
                    field: Field(name: "Status", type: .selection),
                    value: .selection("In Progress")
                )
            ]),
            Task(fieldValues: [
                FieldValue(
                    field: Field(name: "Name", type: .text),
                    value: .text("📝 Write Docs")
                ),
                FieldValue(
                    field: Field(name: "Status", type: .selection),
                    value: .selection("Not Started")
                )
            ])
        ],
        fields: [
            Field(name: "Name", type: .text),
            Field(name: "Status", type: .selection)
        ]
    )
}
