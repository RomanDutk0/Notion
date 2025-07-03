//
//  CardFieldType.swift
//  Notion
//
//  Created by Roman on 03.07.2025.
//

import Foundation

enum CardFieldType: String, Codable, CaseIterable {
    case text
    case number
    case boolean
    case date
    case url
    case selection
}

