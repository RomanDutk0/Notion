//
//  TaskTreckerView.swift
//  Notion
//
//  Created by Roman on 04.07.2025.
//

import SwiftUI

struct TaskTreckerView: View {
    
    let projects: [Project] = [
        .init(emoji: "📄", name: "Research study", status: "In Progress", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "📬", name: "Marketing cam", status: "In Progress", owner: "Sam", avatar: "person.crop.circle.fill"),
        .init(emoji: "🎨", name: "Website redesi", status: "Planning", owner: "Nina", avatar: "person.crop.circle"),
        .init(emoji: "🚀", name: "Product launch", status: "In Progress", owner: "Ben", avatar: "person.crop.circle.badge.checkmark")
    ]
    
    @State private var selectedFilter = " "
    @State private var selectedFilterImage  = " "
    
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
                    CardBoard(projects: projects)
                } else {
                    ProjectsTableView(projects: projects)
                }

            }
            .padding()
            .background(Color.white)
            Spacer()
        }
    }
}



#Preview {
    TaskTreckerView()
}
