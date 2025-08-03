//
//  FieldFactory..swift
//  Notion
//
//  Created by Admin on 03.08.2025.
//

import Foundation
import SwiftUI

struct FieldFactory {
    
    static func defaultValue(for type: FieldType) -> FieldDataValue {
          switch type {
          case .text: return .text(" - ")
          case .number: return .number(0)
          case .boolean: return .boolean(false)
          case .date: return .date(Date())
          case .url: return .url(" - ")
          case .selection: return .selection([])
          }
      }


   static func addFieldToCard(
           name: String,
           type: FieldType,
           optionsString: String,
           fields: Binding<[FieldValue]>
       ) {
           let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
           guard !trimmedName.isEmpty else { return }

           var options: [String] = []
           if type == .selection {
               options = optionsString
                   .split(separator: ",")
                   .map { $0.trimmingCharacters(in: .whitespaces) }
                   .filter { !$0.isEmpty }
           }

           let field = Field(name: trimmedName, type: type, options: options)

           let initialValue: FieldDataValue
           if type == .selection, let first = options.first {
               initialValue = .selection([first])
           } else {
               initialValue = defaultValue(for: type)
           }

           let fieldValue = FieldValue(field: field, value: initialValue)
           fields.wrappedValue.append(fieldValue)
       }

}
