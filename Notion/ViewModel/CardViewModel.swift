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
    
    static func getTaskFields(_ task: Task) ->  [Field]
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
            if case let .selection(values) = statusField.value {
                return values.first ?? "Unknown"
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
        case .selection: return .selection([]) // порожній масив
        }
    }

    static func stringValue(for value: FieldDataValue) -> String {
        switch value {
        case .text(let str): return str
        case .number(let num): return String(num)
        case .boolean(let bool): return bool ? "✅" : "❌"
        case .date(let date): return CardViewModel.dateFormatter.string(from: date)
        case .url(let urlStr): return urlStr
        case .selection(let selections):
           
            return selections.isEmpty ? "—" : selections.joined(separator: ", ")
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

       let defaultValue: FieldDataValue
       switch type {
       case .text: defaultValue = .text("")
       case .number: defaultValue = .number(0)
       case .boolean: defaultValue = .boolean(false)
       case .date: defaultValue = .date(Date())
       case .url: defaultValue = .url("")
       case .selection: defaultValue = .selection([])
       }

       let fieldValue = FieldValue(field: field, value: defaultValue)
       fields.wrappedValue.append(fieldValue)
    }


    
    
    static func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    static func deleteCard(_ tasks: inout [Task] , _ task : Task)  -> Void{
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            print("Deleted")
        }
    }
}
