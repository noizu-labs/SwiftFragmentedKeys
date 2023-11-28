//
//  CacheTag.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `CacheTag` is a concrete implementation of `TagProtocol`, specifically designed for cache versioning.
/// It includes a version number to facilitate cache invalidation mechanisms.
///
class CacheTag: TagProtocol {
    let name: String
    let subject: String?
    private(set) var version: Int

    init(name: String, subject: String? = nil, version: Int = 1) {
        self.name = name
        self.subject = subject
        self.version = version
    }

    func signature() -> String {
        return subject.map { "\(name)-\($0)" } ?? name
    }

    func versioned() -> String {
        return subject.map { "\(name)::\($0)@\(version)" } ?? "\(name)@\(version)"
    }

    func increment() {
        version += 1
    }
}

// MARK: - Extension
// Additional functionalities or helper methods for CacheTag can be added here.
