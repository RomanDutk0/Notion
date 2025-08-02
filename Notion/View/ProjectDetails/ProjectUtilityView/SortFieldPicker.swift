import SwiftUI

struct SortFieldPicker: View {

  let fields: [FieldValue]
  @Binding var selectedSortField: FieldValue?
  @Binding var isPresented: Bool
  @Binding var sortDirection: SortDirection
  @State private var localSelected: FieldValue?
  @State private var localSortDirection: SortDirection = .ascending

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Field to sort by")) {
          ForEach(fields, id: \.field.id) { fieldValue in
            Button(action: {
              localSelected = fieldValue
            }) {
              HStack {
                Text(fieldValue.field.name)
                  .foregroundColor(.primary)
                Spacer()
                if localSelected?.field.id == fieldValue.field.id {
                  Image(systemName: "checkmark")
                    .foregroundColor(.blue)
                }
              }
            }
            .buttonStyle(PlainButtonStyle())
          }
        }

        Section(header: Text("Sort direction")) {
          Picker("Direction", selection: $localSortDirection) {
            Text("Ascending").tag(SortDirection.ascending)
            Text("Descending").tag(SortDirection.descending)
          }
          .pickerStyle(SegmentedPickerStyle())
        }
      }
      .navigationTitle("Sorting")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            isPresented = false
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            selectedSortField = localSelected
            sortDirection = localSortDirection
            isPresented = false
          }
        }
      }
      .onAppear {
        localSelected = selectedSortField
        localSortDirection = sortDirection
      }
    }
  }
}
