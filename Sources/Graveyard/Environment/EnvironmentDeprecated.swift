//
//  Environment.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright (c) 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `Environment` provides a setup for the FragmentedKeys library, encapsulating the settings and storage managers.
/// It acts as a central point for managing the overall configuration and state of the library.
///
/// Usage:
/// This class is typically instantiated at the beginning of the application lifecycle
/// to configure the library according to the specific needs of the application.
///
class EnvironmentDeprecated {
    static let shared = EnvironmentDeprecated()
    
    /// The settings for the library, encapsulating various configuration options.
    let settings: SettingsDeprecated

    /// The storage manager for tags, used to persist tag data.
    let tagStorage: StorageProtocolDeprecated

    /// The storage manager for cached records, used to persist cache data.
    let recordStorage: StorageProtocolDeprecated

    /// Initializes a new `Environment` instance.
    /// If settings are not provided, default settings are used.
    ///
    /// - Parameter settings: An optional `Settings` instance to customize the library configuration. Defaults to `Settings.defaultSettings`.
    init(settings: SettingsDeprecated? = nil) {
        let effectiveSettings = settings ?? SettingsDeprecated.defaultSettings
        
        // Retrieve the storage managers from the settings
        guard let tagStorageManager: StorageProtocolDeprecated = effectiveSettings.get(setting: .defaultTagStorage) else {
            fatalError("DefaultTagStorage setting is not a valid StorageProtocol")
        }

        self.tagStorage = tagStorageManager
        guard let recordStorageManager: StorageProtocolDeprecated = effectiveSettings.get(setting: .defaultDataStorage) else {
            fatalError("DefaultTagStorage setting is not a valid StorageProtocol")
        }
        
        self.recordStorage = recordStorageManager
        
        self.settings = effectiveSettings
    }
}

// MARK: - Extension
// Additional functionalities or customizations for the Environment can be added here.
