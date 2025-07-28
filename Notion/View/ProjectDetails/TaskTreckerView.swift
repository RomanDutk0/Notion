//
//  TaskTreckerView.swift
//  Notion
//
//  Created by Roman on 04.07.2025.
//


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
                        print("Sort tapped")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundColor(.black)
                    }

                    Button {
                        print("Filter tapped")
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.black)
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
                        tasks: $project.taskCards,
                        selectedViewOption: $selectedViewOption,
                        fields: fields,
                        hiddenFieldIDs: $hiddenFieldIDs,
                        searchText: $searchText
                    )

                case .table:
                    ProjectsTableView(
                        fields: fields,
                        tasks: $project.taskCards,
                        hiddenFieldIDs: $hiddenFieldIDs
                    )
                }
            }
            .padding()
            .background(Color.white)

            Spacer()
        }
    }
    

}

#Preview {
    @State var previewProject = Project(
        id: UUID(),
        icon: "📝",
        projectName: "Notion",
        taskCards: [
            Task(fieldValues: [
                FieldValue(
                    field: Field(name: "Name", type: .text),
                    value: .text("🚀 Product Launch")
                ),
                FieldValue(
                    field: Field(name: "Status", type: .selection, options: ["In Progress", "Done"]),
                    value: .selection(["In Progress"])
                ),
                FieldValue(
                    field: Field(name: "End Date", type: .date),
                    value: .date(Date().addingTimeInterval(60 * 60 * 24 * 30))
                )
            ]),
            Task(fieldValues: [
                FieldValue(
                    field: Field(name: "Name", type: .text),
                    value: .text("📝 Write Documentation")
                ),
                FieldValue(
                    field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]),
                    value: .selection(["Not Started"])
                ),
                FieldValue(
                    field: Field(name: "End Date", type: .date),
                    value: .date(Date().addingTimeInterval(60 * 60 * 24 * 10))
                )
            ])
        ],
        template: [
            FieldValue(field: Field(name: "Name", type: .text), value: .text("")),
            FieldValue(field: Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Done"]), value: .selection(["Not Started"])),
            FieldValue(field: Field(name: "End Date", type: .date), value: .date(Date()))
        ],
        viewOptions: [
            ViewOption(title: "By Status", icon: "arrow.right", type: .board, groupByFieldName: "Status"),
            ViewOption(title: "All tasks", icon: "star", type: .table, groupByFieldName: nil),
        ]
    )
    
    let fields = [
        Field(name: "Name", type: .text),
        Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Completed"]),
        Field(name: "End Date", type: .date)
    ]
    
    TaskTreckerView(project: $previewProject, fields: fields)
}
