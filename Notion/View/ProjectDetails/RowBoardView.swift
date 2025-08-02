import SwiftUI

struct RowBoardView: View {

  @State var fields: [Field]
  @Binding var tasks: [Task]
  @Binding var hiddenFieldIDs: Set<UUID>
  @State private var showAddFieldSheet = false
  @StateObject var cardModel = CardViewModel()

  let columnWidth: CGFloat = 140
  var body: some View {
    VStack(spacing: 0) {
      ScrollView([.horizontal], showsIndicators: true) {
        VStack(spacing: 0) {
          HStack(alignment: .center, spacing: 0) {
            ForEach(fields) { field in
              HStack(spacing: 4) {
                Text(field.name)
                  .font(.footnote)
                  .fontWeight(.semibold)
                  .foregroundColor(.primary)
                  .multilineTextAlignment(.center)
                  .padding(.vertical, 8)

                Button(action: {
                  if let index = fields.firstIndex(where: { $0.id == field.id }) {
                    fields.remove(at: index)
                  }
                }) {
                  Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(0.6)
                    .imageScale(.small)
                }
              }
              .frame(width: columnWidth, alignment: .center)
              .padding(.horizontal, 8)
              .background(Color(.systemGray6))
              .cornerRadius(6)
            }

            Button(action: {
              fields.append(Field(name: "New Field", type: .text))
              showAddFieldSheet = true
            }) {
              Image(systemName: "plus.circle")
                .foregroundColor(.blue)
                .imageScale(.medium)
            }
            .padding(.leading, 8)

            Spacer()
          }
          .padding(.horizontal)
          .padding(.vertical, 4)
          .background(Color(.systemGray5))

          Divider()

          ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 0) {
              ForEach($tasks) { $task in
                RowView(
                  cardModel: cardModel,
                  task: $task,
                  tasks: $tasks,
                  fields: fields,
                  hiddenFieldIDs: $hiddenFieldIDs,
                  columnWidth: columnWidth
                )
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                .padding(.vertical, 4)

                Divider()
              }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
          }
        }
      }
    }
    .background(Color(.systemGroupedBackground))

  }
}

struct RowBoardView_Previews: PreviewProvider {
  @State static var tasks: [Task] = [
    Task(fieldValues: [
      FieldValue(field: Field(name: "Title", type: .text), value: .text("🚀 Launch App")),
      FieldValue(field: Field(name: "Status", type: .text), value: .text("In Progress")),
    ]),
    Task(fieldValues: [
      FieldValue(field: Field(name: "Title", type: .text), value: .text("🛠 Fix Bugs")),
      FieldValue(field: Field(name: "Status", type: .text), value: .text("To Do")),
    ]),
  ]

  @State static var hiddenFieldIDs: Set<UUID> = []

  static var previews: some View {
    PreviewWrapper()
  }

  struct PreviewWrapper: View {
    @State var localTasks = tasks
    @State var hidden: Set<UUID> = hiddenFieldIDs

    var body: some View {
      let dummyBinding = Binding<Task>(
        get: { localTasks.first ?? Task(fieldValues: []) },
        set: { updated in
          if let i = localTasks.firstIndex(where: { $0.id == updated.id }) {
            localTasks[i] = updated
          }
        }
      )
      let dummyCardModel = CardViewModel(task: dummyBinding)

      return RowBoardView(
        fields: [
          Field(name: "Title", type: .text),
          Field(name: "Status", type: .text),
        ],
        tasks: $localTasks,
        hiddenFieldIDs: $hidden,
        cardModel: dummyCardModel
      )
    }
  }
}
