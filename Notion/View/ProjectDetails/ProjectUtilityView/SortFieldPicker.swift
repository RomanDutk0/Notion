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

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Sorting by:")
                .font(.title3.bold())
                .padding(.bottom, 5)
                .foregroundColor(.primary)

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(fields, id: \.field.name) { fieldValue in
                        Button(action: {
                            selectedSortField = fieldValue
                            isPresented = false
                            print("Sorting by: \(fieldValue.field.name)")
                        }) {
                            HStack {
                                Text(fieldValue.field.name)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedSortField?.field.name == fieldValue.field.name {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding()
        .frame(width: 240, height: 300) 
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 8)
    }
}
