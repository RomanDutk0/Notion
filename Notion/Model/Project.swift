//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


struct Project : Identifiable {
    let id = UUID()
    var icon: String
    var projectName : String
    var taskCards : [Task]
    
}









