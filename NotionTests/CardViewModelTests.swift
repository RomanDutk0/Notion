//
//  ViewModelTests.swift
//  NotionTests
//
//  Created by Admin on 03.08.2025.
//

import XCTest
@testable import Notion
import SwiftUI

final class CardViewModelTests: XCTestCase {

    @MainActor func testAddTaskToTaskList() {
        let binding = Binding.constant([Task]())
        let viewModel = TaskListViewModel(taskList: binding)
        var tasks = [Task]()
        
        let field1 = Field(name: "Title", type: .text, options: [])
        let field2 = Field(name: "Completed", type: .boolean, options: [])
        
        viewModel.addTask(fields: [field1, field2], tasks: &tasks)
        
        XCTAssertEqual(tasks.count, 1)
        let task = tasks.first!
        XCTAssertEqual(task.fieldValues.count, 2)
        XCTAssertEqual(task.fieldValues[0].field.name, "Title")
        XCTAssertEqual(task.fieldValues[1].field.name, "Completed")
    }

    func testAddFieldToCard() {
        var values: [FieldValue] = []
        let binding = Binding(get: { values }, set: { values = $0 })

        FieldFactory.addFieldToCard(name: "Priority", type: .selection, optionsString: "High, Medium, Low", fields: binding)

        XCTAssertEqual(values.count, 1)
        XCTAssertEqual(values.first?.field.name, "Priority")
        XCTAssertEqual(values.first?.field.options, ["High", "Medium", "Low"])
        if case let .selection(selected) = values.first?.value {
            XCTAssertEqual(selected.first, "High")
        } else {
            XCTFail("Expected selection type")
        }
    }

    func testFieldFormatterStringValue() {
        let text = FieldFormatter.stringValue(for: .text("Hello"))
        XCTAssertEqual(text, "Hello")
        
        let number = FieldFormatter.stringValue(for: .number(42))
        XCTAssertEqual(number, "42.0")
        
        let bool = FieldFormatter.stringValue(for: .boolean(true))
        XCTAssertEqual(bool, "✅")
        
        let selections = FieldFormatter.stringValue(for: .selection(["Red", "Blue"]))
        XCTAssertEqual(selections, "Red, Blue")
    }

    @MainActor func testCreateSortClosureByTextAscending() {
        let field = Field(name: "Title", type: .text, options: [])
        let sortField = FieldValue(field: field, value: .text("A"))
        let viewModel = TaskListViewModel(taskList: .constant([]))

        let closure = viewModel.createSortClosure(selectedSortField: sortField, direction: .ascending)
        let task1 = Task(fieldValues: [FieldValue(field: field, value: .text("A"))])
        let task2 = Task(fieldValues: [FieldValue(field: field, value: .text("Z"))])
        
        XCTAssertTrue(closure?(task1, task2) ?? false)
        XCTAssertFalse(closure?(task2, task1) ?? true)
    }

    @MainActor func testFilterAndSearchTasks() {
        let field = Field(name: "Title", type: .text, options: [])
        let task1 = Task(fieldValues: [FieldValue(field: field, value: .text("First task"))])
        let task2 = Task(fieldValues: [FieldValue(field: field, value: .text("Second task"))])
        let base = Binding.constant([task1, task2])

        let viewModel = TaskListViewModel(taskList: base)
        let filtered = viewModel.filteredAndSortedTasksBinding(
            base: base,
            searchText: "First",
            sort: nil,
            filters: [:],
            fields: [field]
        )

        XCTAssertEqual(filtered.wrappedValue.count, 1)
        XCTAssertEqual(FieldFormatter.stringValue(for: filtered.wrappedValue[0].fieldValues[0].value), "First task")
    }

    @MainActor func testGetFieldFromCardViewModel() {
        let field = Field(name: "Done", type: .boolean, options: [])
        let value = FieldDataValue.boolean(true)
        let task = Task(fieldValues: [FieldValue(field: field, value: value)])

        let viewModel = CardViewModel(task: .constant(task))
        let result = viewModel.getField(.boolean, named: "Done", task)

        if case let .boolean(flag) = result {
            XCTAssertTrue(flag)
        } else {
            XCTFail("Expected boolean value")
        }
    }

    @MainActor func testStatusFieldFromTask() {
        let field = Field(name: "Status", type: .selection, options: ["Todo", "In Progress"])
        let fieldValue = FieldValue(field: field, value: .selection(["In Progress"]))
        let task = Task(fieldValues: [fieldValue])

        let status = CardViewModel.status(for: task, field: "Status")
        XCTAssertEqual(status, "In Progress")
    }
}
