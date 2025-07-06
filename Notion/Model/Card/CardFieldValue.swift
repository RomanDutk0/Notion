//
//  CardFieldValue.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation

enum CardFieldValue: Codable
{
    case text (String)
    case number (Double)
    case boolean (Bool)
    case date (Date)
    case selection (String)
}
