//
//  AddViewOptionSheet.swift
//  Notion
//
//  Created by Admin on 28.07.2025.
//
import SwiftUI

struct AddViewOptionSheet: View {

  @Environment(\.dismiss) var dismiss
  @State private var title: String = ""
  @State private var icon: String = "square.grid.2x2"
  @State private var type: ViewType = .board
  @State private var groupByFieldText: String = ""

  var onAdd: (ViewOption) -> Void

  var body: some View {
    NavigationView {
      Form {
        TextField("View name", text: $title)
        TextField("SF Symbol ", text: $icon)
        Picker("View type", selection: $type) {
          Text("Board").tag(ViewType.board)
          Text("Table").tag(ViewType.table)
        }
        if type == .board {
          TextField("Group by field", text: $groupByFieldText)
        }
      }
      .navigationTitle("New view option")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Сancel") {
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }

            let groupValue =
              type == .board && !groupByFieldText.trimmingCharacters(in: .whitespaces).isEmpty
              ? groupByFieldText
              : ""

            let newOption = ViewOption(
              title: title,
              icon: icon,
              type: type,
              groupByFieldName: groupValue
            )
            onAdd(newOption)
            dismiss()
          }
        }
      }
    }
  }
}
