//
//  FieldVisibilityView.swift
//  Notion
//
//  Created by Admin on 26.07.2025.
//

import SwiftUI

struct FieldVisibilityView: View {
    let fields: [Field]
    @Binding var hiddenFieldIDs: Set<UUID>
    @Environment(\.dismiss) var dismiss

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
            .navigationTitle("Вибір полів")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
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
