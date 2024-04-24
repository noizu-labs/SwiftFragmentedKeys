//
//  StorageProtocol.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright (c) 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `StorageProtocol` defines a common interface for storage mechanisms used in the FragmentedKeys library.
/// It supports operations for fetching, setting, removing, and bulk operations for data management.
///
/// This protocol ensures a unified interface for various storage implementations (e.g., `NSCache`, disk, SQL),
/// facilitating thkkkeir use within the library regardless of the underlying storage mechanism.
///
/// Usage:
/// Implementing classes (e.g., `NSCacheStorage`, `DiskStorage`, `SQLStorage`) should provide concrete
/// implementations of these methods to handle cache data.
///
protocol StorageProtocolDeprecated {
    /// Fetches a value of a specified type from the storage.
    /// Returns `nil` if the value does not exist or cannot be cast to the requested type.
    ///
    /// - Parameter key: A string key to identify the data to fetch.
    /// - Returns: An optional value of the specified type.
    func fetch<T>(for key: String) -> T?
    
    /// Sets a value with a specified key in the storage.
    /// The value must be of a type that the storage layer can handle.
    ///
    /// - Parameters:
    ///   - object: The value to store.
    ///   - key: A string key to identify where to store the data.
    ///   - new: A boolean indicating if this is a new entry (optional use).
    func set<T>(object: T, for key: String, new: Bool)
    
    /// Removes a value associated with the specified key from the storage.
    ///
    /// - Parameter key: A string key identifying the data to remove.
    func remove(for key: String)
    
    /// Clears all data from the storage.
    func removeAll()

    /// Fetches multiple values from the storage for a set of keys.
    /// Returns an array of optional values corresponding to the keys.
    ///
    /// - Parameter keys: An array of string keys to identify the data to fetch.
    /// - Returns: An array of optional values corresponding to the provided keys.
    func multiFetch<T>(for keys: [String]) -> [T?]

    /// Sets multiple values in the storage for a given set of key-value pairs.
    ///
    /// - Parameter keyValues: An array of tuples containing keys and their corresponding values.
    func multiSet<T>(keyValues: [(key: String, object: T)])
}

// MARK: - Extension
// Additional functionalities or helper methods related to storage can be added here.
