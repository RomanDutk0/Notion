//
//  MetadataLoader.swift
//  Notion
//
//  Created by Admin on 21.07.2025.
//

import LinkPresentation
import Combine

final class MetadataLoader: ObservableObject {
    @Published var metadata: LPLinkMetadata?
    @Published var isLoading = false
    @Published var error: Error?

    private let provider = LPMetadataProvider()

    func load(for urlString: String) {
        guard let url = URL(string: urlString) else { return }

        if let cached = MetadataCacheManager.shared.get(for: urlString) {
            self.metadata = cached
            return
        }

        isLoading = true

        provider.startFetchingMetadata(for: url) { [weak self] metadata, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let metadata = metadata {
                    self?.metadata = metadata
                    MetadataCacheManager.shared.set(metadata, for: urlString)
                } else {
                    self?.error = error
                }
            }
        }
    }
}
