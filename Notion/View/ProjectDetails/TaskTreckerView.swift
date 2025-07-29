//  TaskTreckerView.swift
//  Notion
//
//  Created by Roman on 04.07.2025.

import SwiftUI

struct TaskTreckerView: View {

    @Binding var project: Project
    var fields: [Field]

    @State private var selectedFilter = "All tasks"
    @State private var selectedFilterImage  = "arrow.right"
    @State private var hiddenFieldIDs = Set<UUID>()
    @State private var selectedViewOption =  ViewOption(title: "All tasks", icon: "star", type: .table, groupByFieldName: nil)

    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showAddViewOptionSheet = false
    @State private var selectedSortField: FieldValue? = nil
    @State private var showSortMenu = false

    @State private var showFilterMenu = false
    @State private var filterValues: [UUID: FieldDataValue] = [:]
    @State private var filterSelectionValues: [UUID: [String]] = [:]

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Tasks Tracker")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    Text("Stay organized with tasks, your way.")
                        .foregroundColor(.gray)
                }

                HStack {
                    Menu {
                        ForEach(project.viewOptions) { option in
                            Button {
                                selectedViewOption = option
                                selectedFilter = option.title
                                selectedFilterImage = option.icon
                            } label: {
                                Label(option.title, systemImage: option.icon)
                            }
                        }
                        Divider()
                        Button {
                            showAddViewOptionSheet = true
                        } label: {
                            Label("Додати перегляд", systemImage: "plus")
                        }
                    } label: {
                        HStack {
                            Image(systemName: selectedFilterImage)
                            Text(selectedFilter)
                            Image(systemName: "chevron.down")
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    }
                    .sheet(isPresented: $showAddViewOptionSheet) {
                        AddViewOptionSheet { newOption in
                            project.viewOptions.append(newOption)
                        }
                    }

                    Spacer()

                    if isSearching {
                        TextField("Search...", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 200)
                        Button(action: {
                            withAnimation {
                                searchText = ""
                                isSearching = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Button {
                            withAnimation {
                                isSearching = true
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }

                    Button {
                        showSortMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showSortMenu) {
                        SortFieldPicker(
                            fields: project.templateOfFieldValues,
                            selectedSortField: $selectedSortField,
                            isPresented: $showSortMenu
                        )
                        .presentationDetents([.fraction(0.5)])
                    }

                    Button {
                        showFilterMenu.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showFilterMenu) {
                        FilterFieldPickerView(
                            fields: fields.filter { $0.type == .selection },
                            selectedFilterValues: $filterSelectionValues,
                            isPresented: $showFilterMenu
                        )
                        .onDisappear {
                            filterValues = filterSelectionValues.mapValues { .selection($0) }
                        }
                        .presentationDetents([.fraction(0.5)])
                    }

                    Button {
                        print("Add tapped")
                    } label: {
                        Image(systemName: "plus")
                            .padding(12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                switch selectedViewOption.type {
                case .board:
                    CardBoard(
                        tasks: filteredAndSortedTasksBinding(
                            base: $project.taskCards,
                            searchText: searchText,
                            sort: createSortClosure(),
                            filters: filterValues
                        ),
                        selectedViewOption: $selectedViewOption,
                        fields: fields,
                        hiddenFieldIDs: $hiddenFieldIDs
                    )

                case .table:
                    ProjectsTableView(
                        fields: fields,
                        tasks: filteredAndSortedTasksBinding(
                            base: $project.taskCards,
                            searchText: searchText,
                            sort: createSortClosure(),
                            filters: filterValues
                        ),
                        hiddenFieldIDs: $hiddenFieldIDs
                    )
                }
            }
            .padding()
            .background(Color.white)

            Spacer()
        }
    }

    func filteredAndSortedTasksBinding(
        base: Binding<[Task]>,
        searchText: String,
        sort: ((Task, Task) -> Bool)?,
        filters: [UUID: FieldDataValue]
    ) -> Binding<[Task]> {
        Binding<[Task]>(
            get: {
                base.wrappedValue
                    .filter { task in
                        let matchesSearch = searchText.isEmpty || task.fieldValues.contains {
                            CardViewModel.stringValue(for: $0.value).localizedCaseInsensitiveContains(searchText)
                        }
                        let matchesFilters = filters.allSatisfy { (fieldID, filterValue) in
                            task.fieldValues.contains {
                                $0.field.id == fieldID && $0.value.matches(filterValue)
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

    func createSortClosure() -> ((Task, Task) -> Bool)? {
        guard let sortField = selectedSortField?.field.name else { return nil }
        return { lhs, rhs in
            let lhsValue = lhs.fieldValues.first(where: { $0.field.name == sortField })?.value
            let rhsValue = rhs.fieldValues.first(where: { $0.field.name == sortField })?.value
            let lhsString = CardViewModel.stringValue(for: lhsValue ?? .text(""))
            let rhsString = CardViewModel.stringValue(for: rhsValue ?? .text(""))
            return lhsString < rhsString
        }
    }
}

extension FieldDataValue {
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
        case let (.selection(a), .selection(b)):
            return !Set(b).isDisjoint(with: a)
        default:
            return false
        }
    }
}

