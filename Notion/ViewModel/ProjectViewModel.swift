//
//  ProjectViewModel.swift
//  Notion
//
//  Created by Admin on 13.07.2025.
//

import Foundation
import SwiftUI

class ProjectViewModel : ObservableObject
{
    @Published var projects : [Project] = []
    
    static func getAllFields(_ project : Project) -> [Field] {
           var projectFields: [Field] = []
           
            guard
                 !project.taskCards.isEmpty,
                 !project.taskCards[0].fieldValues.isEmpty else {
               return projectFields
           }
           
           for fieldValue in project.taskCards[0].fieldValues {
               projectFields.append(fieldValue.field)
           }
           
           return projectFields
       }
       
    
    func setProjectFields()
    {
    
    }
    
    
}
