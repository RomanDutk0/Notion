//
//  FieldVisibilityView.swift
//  Notion
//
//  Created by Admin on 26.07.2025.
//

import SwiftUI

struct FieldVisibilityView: View {

  @Environment(\.dismiss) var dismiss
  @State var fields: [Field]
  @Binding var hiddenFieldIDs: Set<UUID>

  var body: some View {
    NavigationView {
      List {
        ForEach(fields) { field in
          Button {
            toggleVisibility(field.id)
          } label: {
            HStack {
              Text(field.name)
              Spacer()
              Image(systemName: hiddenFieldIDs.contains(field.id) ? "eye.slash" : "eye")
            }
          }
        }
      }
      .navigationTitle("Select fields")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismiss()
          }
        }
      }
    }
  }

  private func toggleVisibility(_ id: UUID) {
    if hiddenFieldIDs.contains(id) {
      hiddenFieldIDs.remove(id)
    } else {
      hiddenFieldIDs.insert(id)
    }
  }
}
