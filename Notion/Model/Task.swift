//
//  Task.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var fieldValues: [FieldValue]
}
