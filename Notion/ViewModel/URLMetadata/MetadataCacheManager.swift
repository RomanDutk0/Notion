//
//  MetadataCacheManager.swift
//  Notion
//
//  Created by Admin on 21.07.2025.
//

import LinkPresentation

final class MetadataCacheManager {
  static let shared = MetadataCacheManager()

  private let cache = NSCache<NSString, LPLinkMetadata>()

  private init() {}

  func get(for url: String) -> LPLinkMetadata? {
    cache.object(forKey: NSString(string: url))
  }

  func set(_ metadata: LPLinkMetadata, for url: String) {
    cache.setObject(metadata, forKey: NSString(string: url))
  }
}
