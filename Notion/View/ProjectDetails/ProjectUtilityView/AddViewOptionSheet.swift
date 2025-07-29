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
    @State private var groupByFieldText: String = "" // ← замість optional binding

    var onAdd: (ViewOption) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Назва перегляду", text: $title)
                TextField("SF Symbol іконка", text: $icon)
                Picker("Тип перегляду", selection: $type) {
                    Text("Board").tag(ViewType.board)
                    Text("Table").tag(ViewType.table)
                }
                if type == .board {
                    TextField("Групувати за полем", text: $groupByFieldText)
                }
            }
            .navigationTitle("Нова опція перегляду")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Скасувати") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Додати") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }

                        let groupValue = type == .board && !groupByFieldText.trimmingCharacters(in: .whitespaces).isEmpty
                            ? groupByFieldText
                            : nil

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
