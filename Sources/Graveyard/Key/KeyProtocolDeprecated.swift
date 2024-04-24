//
//  KeyProtocol.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `KeyProtocol` defines the required interface for a key in the FragmentedKeys library.
/// It specifies methods for managing tag groups and fetching data using the composite key.
///
protocol KeyProtocolDeprecated {
    /// The name of the key.
    var name: String { get }

    /// The storage mechanism used for caching.
    var storage: StorageProtocolDeprecated { get }

    /// Adds a tag group to the key.
    ///
    /// - Parameter tagGroup: A tag group conforming to `TagProtocol`.
    func addTagGroup(_ tagGroup: TagProtocolDeprecated)

    /// Generates and retrieves the composite cache key string.
    ///
    /// - Returns: A string representing the composite key.
    func getCompositeKey() -> String

    /// Fetches a record from the storage. If the record is not found, executes a provided closure to retrieve it.
    ///
    /// - Parameters:
    ///   - onCacheMiss: A closure executed to fetch the data if it's not in the cache.
    ///   - persist: A flag to determine if the fetched data should be persisted in the cache.
    ///   - block: A flag to determine if the fetch should block the current thread until completion.
    /// - Returns: The fetched data of type T.
    func fetch<T>(onCacheMiss: () -> T, persist: Bool, block: Bool) -> T
}
