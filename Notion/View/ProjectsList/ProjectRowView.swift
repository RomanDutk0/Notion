//
//  ProjectRowView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct ProjectRow : View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "plus")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    ProjectRow(title: "Projects", icon: "arrow.2.circlepath", color: .blue)
}

