//
//  ViewOption.swift
//  Notion
//
//  Created by Admin on 27.07.2025.
//

import Foundation

enum ViewType {
    case board
    case table
}

struct ViewOption: Identifiable {

    let id = UUID()
    let title: String
    let icon: String
    let type: ViewType
    let groupByFieldName: String?
}
