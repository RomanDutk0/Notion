//
//  Project.swift
//  Notion
//
//  Created by Roman on 02.07.2025.
//

import Foundation


    //struct Project: Identifiable, Codable {
    
  //  let id: UUID
//var name: String
 //   var cards: [Card]
 //   var fieldsTemplate: [CardField]
//}

struct Project: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let status: String
    let owner: String
    let avatar: String // image name or system icon
}
