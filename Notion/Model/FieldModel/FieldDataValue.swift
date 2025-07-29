//
//  FieldDataValue.swift
//  Notion
//
//  Created by Admin on 14.07.2025.
//

import Foundation

enum FieldDataValue {
    case text(String)
    case number(Double)
    case boolean(Bool)
    case date(Date)
    case url(String)
    case selection([String])
    
    
}

