//  TaskTreckerView.swift
//  Notion
//
//  Created by Roman on 04.07.2025.

import SwiftUI

struct TaskTreckerView: View {
    
    @Binding var project: Project
    var fields: [Field]
    @StateObject var cardModel = CardViewModel()

    @State private var selectedFilter = "All tasks"
    @State private var selectedFilterImage = "star"
    @State private var searchText = ""
    
    @State private var selectedViewOptionIndex = 1

    @State private var isSearching = false
    @State private var showAddViewOptionSheet = false
    @State private var showSortMenu = false
    @State private var showFilterMenu = false

    private var selectedViewOptionBinding: Binding<ViewOption> {
        Binding(
            get: { project.viewOptions[selectedViewOptionIndex] },
            set: { project.viewOptions[selectedViewOptionIndex] = $0 }
        )
    }

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
                        ForEach(Array(project.viewOptions.enumerated()), id: \.element.id) { index, option in
                            Button {
                                selectedViewOptionIndex = index
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
                            Label("Add new view", systemImage: "plus")
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
                        AddViewOptionSheet(availableFields: project.templateOfFieldValues) { newOption in
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
                            selectedSortField: selectedViewOptionBinding.selectedSortField,
                            isPresented: $showSortMenu,
                            sortDirection: selectedViewOptionBinding.sortDirection
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
                            fields: fields,
                            isPresented: $showFilterMenu,
                            selectedFilterValues: selectedViewOptionBinding.filterValues
                        )
                        .presentationDetents([.fraction(0.5)])
                    }

                    Button {
                        cardModel.addTask(to: $project.taskCards, template: project.templateOfFieldValues)
                    } label: {
                        Image(systemName: "plus")
                            .padding(12)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                switch selectedViewOptionBinding.wrappedValue.type {
                case .board:
                    CardBoard(
                        tasks: cardModel.filteredAndSortedTasksBinding(
                            base: $project.taskCards,
                            searchText: searchText,
                            sort: cardModel.createSortClosure(
                                selectedSortField: selectedViewOptionBinding.selectedSortField.wrappedValue,
                                direction: selectedViewOptionBinding.sortDirection.wrappedValue
                            ),
                            filters: selectedViewOptionBinding.filterValues.wrappedValue,
                            fields: fields
                        ),
                        selectedViewOption: selectedViewOptionBinding,
                        fields: fields,
                        hiddenFieldIDs: selectedViewOptionBinding.hiddenFieldIDs
                    )

                case .table:
                    RowBoardView(
                        fields: fields,
                        tasks: cardModel.filteredAndSortedTasksBinding(
                            base: $project.taskCards,
                            searchText: searchText,
                            sort: cardModel.createSortClosure(
                                selectedSortField: selectedViewOptionBinding.selectedSortField.wrappedValue,
                                direction: selectedViewOptionBinding.sortDirection.wrappedValue
                            ),
                            filters: selectedViewOptionBinding.filterValues.wrappedValue,
                            fields: fields
                        ),
                        hiddenFieldIDs: selectedViewOptionBinding.hiddenFieldIDs
                    )
                }
            }
            .padding()
            .background(Color.white)

            Spacer()
        }
    }
}


