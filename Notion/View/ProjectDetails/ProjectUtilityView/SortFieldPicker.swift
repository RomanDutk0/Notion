//
//  SortFieldPicker.swift
//  Notion
//
//  Created by Admin on 28.07.2025.
//

import SwiftUI

struct SortFieldPicker: View {
  let fields: [FieldValue]
  @Binding var selectedSortField: FieldValue?
  @Binding var isPresented: Bool

  @State private var localSelected: FieldValue?

  var body: some View {
    NavigationView {
      Form {
        Section {
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
            isPresented = false
          }
        }
      }
      .onAppear {
        localSelected = selectedSortField
      }
    }
  }
}
