//
//  FieldDataValue.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation
import SwiftUICore

enum FieldDataValue {
    case text(String)
    case number(Double)
    case boolean(Bool)
    case date(Date)
    case url(String)
    case selection([String])
    
    func matches(_ other: FieldDataValue) -> Bool {
        switch (self, other) {
        case let (.text(a), .text(b)):
            return a.localizedCaseInsensitiveContains(b)
        case let (.number(a), .number(b)):
            return a == b
        case let (.boolean(a), .boolean(b)):
            return a == b
        case let (.date(a), .date(b)):
            return Calendar.current.isDate(a, inSameDayAs: b)
        case let (.url(a), .url(b)):
            return a == b
        case let (.selection(taskValues), .selection(filterValues)):
            return !Set(taskValues).intersection(filterValues).isEmpty
        default:
            return false
        }
    }
        var backgroundColor: Color {
            switch self {
            case .text: return Color.gray.opacity(0.15)
            case .number: return Color.blue.opacity(0.15)
            case .boolean: return Color.green.opacity(0.15)
            case .date: return Color.purple.opacity(0.15)
            case .url: return Color.orange.opacity(0.15)
            case .selection: return Color.pink.opacity(0.15)
            }
            
        }
}

