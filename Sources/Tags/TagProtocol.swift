//
//  TagProtocol.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright (c) 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `TagProtocol` defines a common interface for all tag types in the FragmentedKeys library.
/// It provides essential functionalities for generating a signature or versioned identifier for a tag.
///
protocol TagProtocol {
    var name: String { get }
    var subject: String? { get }

    func signature() -> String
    func versioned() -> String
}

// MARK: - Extension
// Common implementations of TagProtocol methods can be added here if applicable.
