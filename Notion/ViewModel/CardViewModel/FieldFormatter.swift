//
//  FieldFormatter.swift
//  Notion
//
//  Created by Admin on 03.08.2025.
//

import Foundation

struct FieldFormatter {
    
    static var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }
    
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    static func stringValue(for value: FieldDataValue) -> String {
            switch value {
            case .text(let str): return str
            case .number(let num): return String(num)
            case .boolean(let bool): return bool ? "✅" : "❌"
            case .date(let date): return dateFormatter.string(from: date)
            case .url(let urlStr): return urlStr
            case .selection(let selections):
                return selections.isEmpty ? "—" : selections.joined(separator: ", ")
            }
        }

    static func formatted(_ date: Date) -> String {
           dateFormatter.string(from: date)
       }
}
