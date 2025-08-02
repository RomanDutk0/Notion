//
//  JumpCardView.swift
//  Notion
//
//  Created by Roman on 05.07.2025.
//

import SwiftUI

struct JumpCard: View {
  let title: String
  let icon: String

  var body: some View {
    VStack {
      Image(systemName: icon)
        .font(.largeTitle)
        .foregroundColor(.blue)
        .padding()
        .background(Color(UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))

      Text(title)
        .font(.footnote)
        .multilineTextAlignment(.center)
        .frame(width: 100)
    }
    .padding()
    .background(Color(UIColor.systemGray5))
    .cornerRadius(16)
  }
}

#Preview {
  JumpCard(title: "Projects", icon: "arrow.2.circlepath")
}
