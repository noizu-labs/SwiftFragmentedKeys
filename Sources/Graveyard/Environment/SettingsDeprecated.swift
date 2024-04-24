//
//  Settings.swift
//  FragmentedKeys
//
//  Created by Keith Brings on [Date of Creation].
//  Copyright (c) 2023 Noizu Labs, Inc. All rights reserved.
//

import Foundation

/// `ConfigSetting` is an enumeration that defines the various configurable settings within the FragmentedKeys library.
/// It acts as a key for setting and retrieving configuration values.
///
/// The enum includes settings for default tag storage, default data storage, and other potential configuration options.
///
enum ConfigSetting: Hashable {
    case defaultTagStorage
    case defaultDataStorage
    // Additional configuration settings can be added here.
}

/// `Settings` is a structure that holds and manages the configuration settings for the FragmentedKeys library.
/// It allows for the customization and modification of settings like the default storage mechanisms.
///
/// Usage:
/// This structure can be used to configure the library at initialization or to modify settings at runtime.
///
struct SettingsDeprecated {
    static var factorySettings = SettingsDeprecated(name: "FactorySettings", settings: [
        .defaultTagStorage: NSCacheStorageDeprecated.shared,
        .defaultDataStorage: NSCacheStorageDeprecated.shared
    ])
    static var defaultSettings = factorySettings

    private(set) var name: String
    private(set) var settings: [ConfigSetting: Any]

    /// Initializes a new `Settings` instance.
    ///
    /// - Parameters:
    ///   - name: A name for this particular settings configuration.
    ///   - settings: A dictionary mapping `ConfigSetting` keys to their corresponding values.
    init(name: String, settings: [ConfigSetting: Any]) {
        self.name = name
        self.settings = settings
    }
    
    /// Retrieves a setting from the dictionary with a generic return type.
    ///
    /// - Parameter setting: The `ConfigSetting` key for the desired setting.
    /// - Returns: An optional value of the specified type.
    func get<T>(setting: ConfigSetting) -> T? {
        return settings[setting] as? T
    }
    
    /// Sets a value for a given setting in the dictionary.
    ///
    /// - Parameters:
    ///   - setting: The `ConfigSetting` key for the setting to modify.
    ///   - value: The new value to be set for the specified setting.
    mutating func set<T>(setting: ConfigSetting, value: T) {
        settings[setting] = value
    }
}

// MARK: - Extension
// Additional functionalities or helper methods related to settings can be added here.
