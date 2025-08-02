//
//  URLPreview.swift
//  Notion
//
//  Created by Admin on 21.07.2025.
//

import LinkPresentation
import SwiftUI

struct URLPreview: View {
  let urlString: String

  @StateObject private var loader = MetadataLoader()
  @State private var iconImage: UIImage?

  var body: some View {
    Group {
      if loader.isLoading {
        ProgressView()
          .frame(height: 40)
      } else if let metadata = loader.metadata {
        HStack(spacing: 8) {
          if let icon = iconImage {
            Image(uiImage: icon)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 24, height: 24)
              .cornerRadius(4)
          } else {
            Image(systemName: "link")
              .font(.system(size: 20))
          }

          VStack(alignment: .leading, spacing: 2) {
            Text(metadata.title ?? urlString)
              .font(.subheadline)
              .lineLimit(1)
            Text(URL(string: urlString)?.host ?? "")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .onAppear {
          loadIcon(metadata: metadata)
        }
      } else {
        fallback
      }
    }
    .onAppear {
      loader.load(for: urlString)
    }
  }

  private func loadIcon(metadata: LPLinkMetadata) {
    if let provider = metadata.iconProvider {
      provider.loadObject(ofClass: UIImage.self) { object, _ in
        if let image = object as? UIImage {
          DispatchQueue.main.async {
            self.iconImage = image
          }
        }
      }
    }
  }

  @ViewBuilder
  private var fallback: some View {
    HStack {
      Image(systemName: "link")
      Text(urlString)
        .lineLimit(1)
        .font(.caption)
      Spacer()
    }
    .frame(height: 40)
    .padding(8)
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }
}

#Preview {
  URLPreview(urlString: "https://www.apple.com")
}
