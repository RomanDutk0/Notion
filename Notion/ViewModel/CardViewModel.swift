//
//  CardViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation


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
    
}
