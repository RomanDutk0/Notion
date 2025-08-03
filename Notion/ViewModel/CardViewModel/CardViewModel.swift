//
//  CardViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUICore
import SwiftUI


@MainActor
class CardViewModel: ObservableObject {
    @Binding var task: Task
    
    convenience init() {
        self.init(task: .constant(Task(fieldValues: [])))
    }
    
    init(task : Binding<Task>) {
        self._task = task
    }
    
    /// Повертає всі поля конкретної картки
    func getTaskFields(_ task: Task) -> [Field] {
            task.fieldValues.map { $0.field }
        }
        

    /// Шукає конкретне поле
    func getField(_ type: FieldType, named: String, _ task: Task) -> FieldDataValue? {
            return task.fieldValues.first { $0.field.name == named && $0.field.type == type }?.value
        }
    
    static func status(for task: Task, field: String) -> String {
            if let statusField = task.fieldValues.first(where: { $0.field.name == field }) {
                if case let .selection(values) = statusField.value {
                    return values.first ?? "Unknown"
                }
            }
            return "Unknown"
        }

}
