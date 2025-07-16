//
//  TaskTreckerView.swift
//  Notion
//
//  Created by Roman on 04.07.2025.
//

import SwiftUI

struct TaskTreckerView: View {
    
    var tasks: [Task]
    var fields: [Field]
    @State private var selectedFilter = ""
    @State private var selectedFilterImage  = "arrow.right"
    
    var body: some View {
        VStack{
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
                            Button("By Status") {
                                selectedFilterImage =  "arrow.right"
                                selectedFilter = "By Status"
                                print("Filter by Status")
                            }
                                Button("All tasks") {
                                    selectedFilterImage = "star"
                                    selectedFilter = "All tasks"
                                    print("All tasks")
                                }
                                
                                Button("New View") {
                                    selectedFilterImage =  "plus"
                                    selectedFilter = "New View"
                                    print("New View")
                                }
                            } label: {
                                HStack {
                                    Image(systemName : selectedFilterImage )
                                    Text(selectedFilter)
                                    Image(systemName: "chevron.down")
                                }
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                                .foregroundColor(.black)
                            }

                    
                    Spacer()
                    
                    Button {
                        print("Search tapped")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
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
                if selectedFilter == "By Status" {
                     CardBoard(tasks: tasks , fields: fields)
                } else {
                    ProjectsTableView(fields: fields, tasks:tasks )
                }

            }
            .padding()
            .background(Color.white)
            Spacer()
        }
    }
}



#Preview {
    let fields = [
        Field(name: "Emoji", type: .text),
        Field(name: "Name", type: .text),
        Field(name: "Status", type: .selection, options: ["Not Started", "In Progress", "Completed", "Planning"]),
        Field(name: "Priority", type: .selection, options: ["High", "Medium", "Low", "Critical"])
    ]
    
    let tasks = [
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🚀")),
            FieldValue(field: fields[1], value: .text("Product Launch")),
            FieldValue(field: fields[2], value: .selection("In Progress")),
            FieldValue(field: fields[3], value: .selection("High"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("📝")),
            FieldValue(field: fields[1], value: .text("Write Documentation")),
            FieldValue(field: fields[2], value: .selection("Not Started")),
            FieldValue(field: fields[3], value: .selection("Medium"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🎨")),
            FieldValue(field: fields[1], value: .text("Design New Logo")),
            FieldValue(field: fields[2], value: .selection("Completed")),
            FieldValue(field: fields[3], value: .selection("Low"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("📣")),
            FieldValue(field: fields[1], value: .text("Marketing Campaign")),
            FieldValue(field: fields[2], value: .selection("Planning")),
            FieldValue(field: fields[3], value: .selection("High"))
        ]),
        Task(fieldValues: [
            FieldValue(field: fields[0], value: .text("🔍")),
            FieldValue(field: fields[1], value: .text("QA Testing")),
            FieldValue(field: fields[2], value: .selection("In Progress")),
            FieldValue(field: fields[3], value: .selection("Critical"))
        ])
    ]
    TaskTreckerView(tasks: tasks , fields : fields )
}
