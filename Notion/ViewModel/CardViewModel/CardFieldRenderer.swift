//
//  CardFieldRenderer.swift
//  Notion
//
//  Created by Admin on 03.08.2025.
//

import Foundation
import SwiftUI

struct CardFieldRenderer {
    
    @ViewBuilder
    static func fieldRow(_ fieldValue: FieldValue) -> some View {
        let name = fieldValue.field.name
        switch fieldValue.value {
        case .text(let text):
            labeledRow(name, text, .yellow.opacity(0.2))
        case .number(let number):
            labeledRow(name, String(number), .blue.opacity(0.2))
        case .boolean(let flag):
            labeledRow(name, flag ? "✅" : "❌", .green.opacity(0.2))
        case .date(let date):
            labeledRow(name,  FieldFormatter.formatted(date) , .purple.opacity(0.2))
        case .url(let url):
            URLPreview(urlString: url)
        case .selection(let options):
            labeledRow(name, options.joined(separator: ", "), .orange.opacity(0.2))
        }
    }

    static func labeledRow(_ label: String, _ value: String, _ background: Color) -> some View {
        HStack {
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .padding(8)
                .background(background)
                .cornerRadius(8)
            Spacer()
        }
    }
}
