//
//  ContentView.swift
//  Notion
//
//  Created by Admin on 17.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var projectModel = ProjectViewModel()
    
    var body: some View {
        ProjectsListView(projectModel: projectModel)
    }
}

#Preview {
    ContentView()
}
