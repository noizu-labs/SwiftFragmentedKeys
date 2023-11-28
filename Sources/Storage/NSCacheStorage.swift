//
//  NSCacheStorage.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright (c) 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `NSCacheStorage` is a class that conforms to `StorageProtocol`, implementing storage functionalities using `NSCache`.
/// It provides a thread-safe caching mechanism suitable for storing transient data in memory.
///
/// Usage:
/// This class can be used as a caching layer in applications, allowing for efficient, temporary storage of data.
///
class NSCacheStorage: StorageProtocol {
    static let shared = NSCacheStorage()
    private let cache = NSCache<NSString, AnyObject>()

    /// Retrieves a cached value for a specific key.
    ///
    /// - Parameter key: A string key to identify the data to fetch.
    /// - Returns: An optional value of the specified type.
    func fetch<T>(for key: String) -> T? {
        return cache.object(forKey: key as NSString) as? T
    }

    /// Caches an object for a specific key.
    ///
    /// - Parameters:
    ///   - object: The value to store.
    ///   - key: A string key to identify where to store the data.
    ///   - new: A boolean indicating if this is a new entry (not used in this implementation).
    func set<T>(object: T, for key: String, new: Bool = false) {
        if let obj = object as? AnyObject {
            cache.setObject(obj, forKey: key as NSString)
        }
    }

    /// Removes a cached value for a specific key.
    ///
    /// - Parameter key: A string key identifying the data to remove.
    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    /// Clears the entire cache.
    func removeAll() {
        cache.removeAllObjects()
    }

    /// Fetches multiple values from the cache for a set of keys.
    ///
    /// - Parameter keys: An array of string keys to identify the data to fetch.
    /// - Returns: An array of optional values corresponding to the provided keys.
    func multiFetch<T>(for keys: [String]) -> [T?] {
        return keys.map { fetch(for: $0) }
    }

    /// Sets multiple values in the cache for a given set of key-value pairs.
    ///
    /// - Parameter keyValues: An array of tuples containing keys and their corresponding values.
    func multiSet<T>(keyValues: [(key: String, object: T)]) {
        for (key, object) in keyValues {
            set(object: object, for: key)
        }
    }
}

// MARK: - Extension
// Additional functionalities or optimizations for NSCacheStorage can be added here.
