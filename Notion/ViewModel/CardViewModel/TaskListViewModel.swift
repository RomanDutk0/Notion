//
//  TaskListViewModel.swift
//  Notion
//
//  Created by Admin on 03.08.2025.
//

import Foundation
import SwiftUI

@MainActor
class TaskListViewModel: ObservableObject {
    
    @Binding var taskList: [Task]
    
    convenience init() {
           self.init(taskList: .constant([]))
       }

       init(taskList: Binding<[Task]>) {
           self._taskList = taskList
       }
    
    func addTask(fields: [Field], tasks: inout [Task]) {
        let newFieldValues = fields.map { field in
            FieldValue(field: field, value: FieldFactory.defaultValue(for: field.type))
        }
        tasks.append(Task(fieldValues: newFieldValues))
    }
    
    func addTask(to tasks: Binding<[Task]>, template: [FieldValue]) {
            tasks.wrappedValue.append(Task(fieldValues: template))
        }
 
    func deleteCard(_ tasks: inout [Task], _ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            print("Deleted")
        }
    }
    
    func filteredAndSortedTasksBinding(
        base: Binding<[Task]>,
        searchText: String,
        sort: ((Task, Task) -> Bool)?,
        filters: [UUID: FieldDataValue],
        fields:[Field]
    ) -> Binding<[Task]> {
        Binding<[Task]>(
            get: {
                base.wrappedValue
                    .filter { task in
                        let matchesSearch = searchText.isEmpty || task.fieldValues.contains {
                            FieldFormatter.stringValue(for: $0.value).localizedCaseInsensitiveContains(searchText)
                        }
                        let matchesFilters = filters.allSatisfy { (fieldID, filterValue) in
                            guard let fieldName = fields.first(where: { $0.id == fieldID })?.name else { return false }
                            return task.fieldValues.contains {
                                $0.field.name == fieldName && $0.value.matches(filterValue)
                            }
                        }
                        return matchesSearch && matchesFilters
                    }
                    .sorted(by: sort ?? { _, _ in false })
            },
            set: { newTasks in
                for task in newTasks {
                    if let index = base.wrappedValue.firstIndex(where: { $0.id == task.id }) {
                        base.wrappedValue[index] = task
                    }
                }
            }
        )
    }
    
    
    func createSortClosure(selectedSortField: FieldValue?, direction: SortDirection) -> ((Task, Task) -> Bool)? {
        guard let sortFieldName = selectedSortField?.field.name else {
            return nil
        }
        
        return { lhs, rhs in
            guard
                let lhsValue = lhs.fieldValues.first(where: { $0.field.name == sortFieldName })?.value,
                let rhsValue = rhs.fieldValues.first(where: { $0.field.name == sortFieldName })?.value
            else {
                return false
            }
            
            let comparisonResult: Bool
            
            switch (lhsValue, rhsValue) {
            case let (.text(a), .text(b)):
                comparisonResult = a < b
            case let (.number(a), .number(b)):
                comparisonResult = a < b
            case let (.date(a), .date(b)):
                comparisonResult = a < b
            case let (.selection(a), .selection(b)):
                comparisonResult = (a.first ?? "") < (b.first ?? "")
            default:
                comparisonResult = false
            }
            
            return direction == .ascending ? comparisonResult : !comparisonResult
        }
    }
}
