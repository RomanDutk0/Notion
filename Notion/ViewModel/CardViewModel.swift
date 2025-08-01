//
//  CardViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUI
import SwiftUICore

@MainActor
class CardViewModel: ObservableObject {

  @Binding var task: Task

  convenience init() {
    self.init(task: .constant(Task(fieldValues: [])))
  }

  init(task: Binding<Task>) {
    self._task = task
  }

  func getTaskFields(_ task: Task) -> [Field] {
    task.fieldValues.map { $0.field }
  }

  func dateString(from date: Date) -> String {
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

  static func status(for task: Task, field: String) -> String {
    if let statusField = task.fieldValues.first(where: { $0.field.name == field }) {
      if case let .selection(values) = statusField.value {
        return values.first ?? "Unknown"
      }
    }
    return "Unknown"
  }

  func getField(_ type: FieldType, named: String, _ task: Task) -> FieldDataValue? {
    return task.fieldValues.first { $0.field.name == named && $0.field.type == type }?.value
  }

  func addTask(fields: [Field], tasks: inout [Task]) {
    let newFieldValues = fields.map { field in
      FieldValue(field: field, value: defaultValue(for: field.type))
    }
    tasks.append(Task(fieldValues: newFieldValues))
  }

  func defaultValue(for type: FieldType) -> FieldDataValue {
    switch type {
    case .text: return .text("")
    case .number: return .number(0)
    case .boolean: return .boolean(false)
    case .date: return .date(Date())
    case .url: return .url("")
    case .selection: return .selection([])
    }
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

  func labeledRow(_ label: String, _ value: String, backgroundColor: Color) -> some View {
    HStack {
      Text(value)
        .font(.body)
        .foregroundColor(.primary)
        .padding(8)
        .background(backgroundColor)
        .cornerRadius(8)
      Spacer()
    }
  }

  func addFieldToCard(
    name: String,
    type: FieldType,
    optionsString: String,
    fields: Binding<[FieldValue]>
  ) {
    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmedName.isEmpty else { return }

    var options: [String] = []
    if type == .selection {
      options =
        optionsString
        .split(separator: ",")
        .map { $0.trimmingCharacters(in: .whitespaces) }
        .filter { !$0.isEmpty }
    }

    let field = Field(name: trimmedName, type: type, options: options)
    let defaultValue = defaultValue(for: type)
    let fieldValue = FieldValue(field: field, value: defaultValue)
    fields.wrappedValue.append(fieldValue)
  }

  static func formatted(_ date: Date) -> String {
    dateFormatter.string(from: date)
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
    fields: [Field]
  ) -> Binding<[Task]> {
    Binding<[Task]>(
      get: {
        base.wrappedValue
          .filter { task in
            let matchesSearch =
              searchText.isEmpty
              || task.fieldValues.contains {
                CardViewModel.stringValue(for: $0.value).localizedCaseInsensitiveContains(
                  searchText)
              }
            let matchesFilters = filters.allSatisfy { (fieldID, filterValue) in
              guard let fieldName = fields.first(where: { $0.id == fieldID })?.name else {
                return false
              }
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

  func createSortClosure(selectedSortField: FieldValue?) -> ((Task, Task) -> Bool)? {
    guard let sortField = selectedSortField?.field.name else { return nil }

    return { lhs, rhs in
      guard
        let lhsValue = lhs.fieldValues.first(where: { $0.field.name == sortField })?.value,
        let rhsValue = rhs.fieldValues.first(where: { $0.field.name == sortField })?.value
      else {
        return false
      }

      switch (lhsValue, rhsValue) {
      case let (.text(a), .text(b)):
        return a < b
      case let (.number(a), .number(b)):
        return a < b
      case let (.date(a), .date(b)):
        return a < b
      case let (.selection(a), .selection(b)):
        return (a.first ?? "") < (b.first ?? "")
      default:
        return false
      }
    }
  }

  @ViewBuilder
  func fieldRow(_ fieldValue: FieldValue) -> some View {
    let name = fieldValue.field.name

    switch fieldValue.value {
    case .text(let text):
      labeledRow(name, text, backgroundColor: .yellow.opacity(0.2))
    case .number(let number):
      labeledRow(name, String(number), backgroundColor: .blue.opacity(0.2))
    case .boolean(let flag):
      labeledRow(name, flag ? "✅" : "❌", backgroundColor: .green.opacity(0.2))
    case .date(let date):
      labeledRow(name, CardViewModel.formatted(date), backgroundColor: .purple.opacity(0.2))
    case .url(let url):
      URLPreview(urlString: url)
    case .selection(let option):
      labeledRow(name, option.joined(separator: ", "), backgroundColor: .orange.opacity(0.2))
    }
  }

  func addTask(to tasks: Binding<[Task]>, template: [FieldValue]) {
    tasks.wrappedValue.append(Task(fieldValues: template))
  }

}
