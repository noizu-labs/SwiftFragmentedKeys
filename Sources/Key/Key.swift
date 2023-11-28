//
//  Key.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `Key` is a concrete implementation of `KeyProtocol`.
/// It represents a composite key, assembled from multiple tags, with a defined name and storage mechanism.
///
class Key: KeyProtocol {
    private var name: String
    private var tagGroups: [TagProtocol]
    private var storage: StorageProtocol

    init(name: String, tagGroups: [TagProtocol] = [], storage: StorageProtocol) {
        self.name = name
        self.tagGroups = tagGroups
        self.storage = storage
    }

    /// Adds a tag group to the key.
    func addTagGroup(_ tagGroup: TagProtocol) {
        tagGroups.append(tagGroup)
    }

    /// Generates and retrieves the composite cache key string.
    func getCompositeKey() -> String {
        let tagSignatures = tagGroups.map { $0.signature() }
        return "\(name):" + tagSignatures.joined(separator: ":")
    }

    /// Fetches a record from the storage. If the record is not found, executes `onCacheMiss` closure to retrieve it.
    ///
    /// - Parameters:
    ///   - onCacheMiss: A closure executed to fetch the data if it's not in the cache.
    ///   - persist: Boolean flag to determine if the fetched data should be persisted in the cache.
    ///   - block: Boolean flag to determine if the fetch should block the current thread until completion.
    /// - Returns: The fetched data of type T.
    func fetch<T>(onCacheMiss: () -> T, persist: Bool = true, block: Bool = true) -> T {
        let key = getCompositeKey()

        if let cachedData: T = storage.fetch(for: key) {
            return cachedData
        } else {
            let newData = onCacheMiss()
            if persist {
                storage.set(object: newData, for: key)
            }
            return newData
        }
    }
}
