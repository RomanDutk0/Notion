//
//  CardViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUICore


class CardViewModel : ObservableObject
{
    
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    static func getTaskFields(_ task: Task) -> [Field]
    {
        var fields : [Field] = []
        
        for temp in task.fieldValues
        {
            fields.append(temp.field)
        }
        
        return fields
    }
    
    static func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    
   static func status(for task: Task) -> String {
        if let statusField = task.fieldValues.first(where: { $0.field.name == "Status" }) {
            if case let .selection(value) = statusField.value {
                return value
            }
        }
        return "Unknown"
    }
    
    static func getField(_ type: FieldType, named: String , _ task : Task) -> FieldDataValue? {
        return task.fieldValues.first { $0.field.name == named && $0.field.type == type }?.value
    }
    
    static func addTask(fields : [Field] , tasks : inout [Task]) {
        let newFieldValues = fields.map { field in
            FieldValue(field: field, value: defaultValue(for: field.type))
        }
        tasks.append(Task(fieldValues: newFieldValues))
    }
    
    static func defaultValue(for type: FieldType) -> FieldDataValue {
        switch type {
        case .text: return .text("")
        case .number: return .number(0)
        case .boolean: return .boolean(false)
        case .date: return .date(Date())
        case .url: return .url("")
        case .selection: return .selection("")
        }
    }
    
    static func stringValue(for value: FieldDataValue) -> String {
        switch value {
        case .text(let str): return str
        case .number(let num): return String(num)
        case .boolean(let bool): return bool ? "✅" : "❌"
        case .date(let date): return CardViewModel.dateFormatter.string(from: date)
        case .url(let urlStr): return urlStr
        case .selection(let selection): return selection
        }
    }
    static func labeledRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
        }
    }
    
    
    static func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
