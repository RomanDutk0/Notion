//
//  CardView.swift
//  Notion
//
//  Created by Roman on 03.07.2025.
//

import SwiftUI

struct CardView: View {
    
    var emoji: String = ""
    var mainTitle: String = ""
    var cardPriority: String = ""
    var cardTaskType: String = ""
    
    var body: some View {
        Button{
            print()
        }label:{
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Button{print()
                    }label : {
                        Image(systemName: emoji)
                            .foregroundColor(.red)
                    }
                    Button{
                        print()
                    }label :{
                        Text(mainTitle)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading,spacing: 8) {
                   
                    Button{
                        print()
                    } label : {
                        Text(cardPriority)
                            .font(.caption)
                            .foregroundColor(Color(.black))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(6)
                    }
                   
                    Button {
                        print()
                    } label:{
                        HStack(spacing: 4) {
                            Image(systemName: "bubble.left")
                            Text(cardTaskType)
                                .foregroundColor(Color(.black))
                        }
                    }
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(6)
                }
                
            }
            .frame(width: 235, height: 85)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            )
        }
    }
}

#Preview {
    CardView(emoji: "📄",
              mainTitle: "Title",
              cardPriority: "Priority",
              cardTaskType: "TaskType")
}
