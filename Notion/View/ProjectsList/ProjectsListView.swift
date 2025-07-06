//
//  ProjectsListView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

    

struct ProjectsListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Jump back in")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            JumpCard(title: "Projects", icon: "arrow.2.circlepath")
                            JumpCard(title: "Quarterly sales planning", icon: "book.closed")
                            JumpCard(title: "Tasks", icon: "checkmark.circle")
                        }
                        .padding(.horizontal)
                    }
                    
                    // Private section
                    Text("Private")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ProjectRow(title: "Projects", icon: "arrow.2.circlepath", color: .blue)
                        ProjectRow(title: "Tasks Tracker", icon: "checkmark.circle.fill", color: .green)
                        ProjectRow(title: "This", icon: "doc.text", color: .gray)
                        ProjectRow(title: "Projects & Tasks", icon: "target", color: .gray)
                        ProjectRow(title: "Untitled", icon: "doc", color: .gray)
                        ProjectRow(title: "Untitled", icon: "doc", color: .gray)
                        ProjectRow(title: "Untitled", icon: "doc", color: .gray)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.white)
            .navigationTitle("Dashboard")
        }
    }
}




struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}

