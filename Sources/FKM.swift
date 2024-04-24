//
//  File.swift
//  
//
//  Created by Keith Brings on 4/24/24.
//

import Foundation

// MARK: - Protocols
protocol ReportSelf {
//    static var kind: String { get }
}

protocol RecordHandleProtocol {}

protocol SettingsProtocol {
    init?(from: [String: Any?])
    func 
    
    static func from(dictionary: [String: Any?]?) -> Self
    static func cast(instance: Self, to: [String:Any?].Type) -> [String:Any?]
    static func merge(_ lhs: Self?, with: Self?) -> Self?
    func merge(with: Self?) -> Self
}

protocol ConfigurationProtocol : SettingsProtocol {}

protocol RuntimeSettingsProtocol : SettingsProtocol {}

protocol OptionsProtocol : SettingsProtocol {}

protocol GetOptionsProtocol: OptionsProtocol {}
protocol SetOptionsProtocol: OptionsProtocol {}
protocol ClearOptionsProtocol: OptionsProtocol {}
protocol MultiGetOptionsProtocol: OptionsProtocol {}
protocol MultiSetOptionsProtocol: OptionsProtocol {}
protocol MultiClearOptionsProtocol: OptionsProtocol {}


protocol Serializable : ReportSelf {
    func serialize() -> Data
    static func deserialize(_ data: Data) -> Self?
}

// This should be an and enum like {ok, something}, {error, something}, ...
protocol RequestOutcomeProtocol {
}


protocol DataStoreOptions {
    associatedtype GetOptions: GetOptionsProtocol
    associatedtype SetOptions: SetOptionsProtocol
    associatedtype ClearOptions: ClearOptionsProtocol
    associatedtype MultiGetOptions: MultiGetOptionsProtocol
    associatedtype MultiSetOptions: MultiSetOptionsProtocol
    associatedtype MultiClearOptions: MultiClearOptionsProtocol
}

protocol DataStoreProtocol : ReportSelf {
    associatedtype Configuration: ConfigurationProtocol
    associatedtype RuntimeSettings: RuntimeSettingsProtocol
    associatedtype Options: DataStoreOptions
    associatedtype RequestOutcome: RequestOutcomeProtocol
    
    typealias MultiGetKeyPair = RecordHandleProtocol // and ptions
    typealias MultiSetKeyPair = (RecordHandleProtocol, Serializable?) // and options
    typealias MultiClearKeyPair = RecordHandleProtocol // and options
    typealias MultiGetResponseKeyPair = (RecordHandleProtocol, Serializable?) // this instead of Serializable we should have a struct indicating (Type, Data?)
    
    var config: Configuration {get}
    var runtime: RuntimeSettings {get set}
    
    func get<T: Serializable>(_ key: RecordHandleProtocol, options: Options.GetOptions?) -> T?
    func set(_ key: RecordHandleProtocol, record: Serializable?,  options: Options.SetOptions?) -> RequestOutcome
    func clear(_ key: RecordHandleProtocol, options: Options.ClearOptions?) -> RequestOutcome
    
    func multiGet(keys: [MultiGetKeyPair], options: Options.MultiGetOptions?) -> [MultiGetResponseKeyPair]
    func multiSet(_ keys: [MultiSetKeyPair],  options: Options.MultiSetOptions?) -> RequestOutcome
    func multiClear(_ keys: [MultiClearKeyPair], options: Options.MultiClearOptions?) -> RequestOutcome
    
}

protocol DataStoreAndDefaultOptions {
    associatedtype T: DataStoreProtocol
    
    var store: T {get set}; // should be a reference
    var defaultGetOptions: T.Options.GetOptions? {get set}
    var defaultSetOptions: T.Options.SetOptions? {get set}
    var defaultClearOptions: T.Options.ClearOptions? {get set}
    var defaultMultiGetOptions: T.Options.MultiGetOptions? {get set}
    var defaultMultiSetOptions: T.Options.MultiSetOptions? {get set}
    var defaultMultiClearOptions: T.Options.MultiClearOptions? {get set}

}

protocol TagSubject : ReportSelf {
}

protocol TagProtocol : RecordHandleProtocol {
    associatedtype Name: Any
    associatedtype Subject: TagSubject
    associatedtype Version: Serializable
    
    var store: any DataStoreAndDefaultOptions { get }

    var name: Name {get}
    var subject: Subject? {get}

    func version() -> Version?
}

protocol KeyProtocol : RecordHandleProtocol {
    associatedtype Name: Any
    var store: any DataStoreAndDefaultOptions { get }

    var name: Name {get}
    var tags: [any TagProtocol] {get}
}

protocol KeyRing {
        
}

//// MARK: - Structs
//
//struct DataStoreRegistry {
//    static func register(name: String, store: DataStoreProtocol) {
//        // Implementation pending
//    }
//    
//    static func instance(name: String) -> DataStoreProtocol? {
//        // Implementation pending
//        return nil
//    }
//}
//
//// MARK: - Classes
//
//class FKR {
//    static var defaultTagStore: DataStoreProtocol!
//    static var defaultRecordStore: DataStoreProtocol!
//    static var telemetry: Telemetry!
//    
//    static func initialize(defaultTagStore: DataStoreProtocol, defaultRecordStore: DataStoreProtocol) {
//        self.defaultTagStore = defaultTagStore
//        self.defaultRecordStore = defaultRecordStore
//        self.telemetry = Telemetry()
//    }
//    
//    static func fetch(key: Key) -> Data? {
//        // Implementation pending
//        return nil
//    }
//    
//    static func set(key: Key, value: Data) {
//        // Implementation pending
//    }
//    
//    static func remove(key: Key) {
//        // Implementation pending
//    }
//    
//    static func multiFetch(keys: [Key]) -> [Key: Data] {
//        // Implementation pending
//        return [:]
//    }
//    
//    static func multiSet(keyValuePairs: [Key: Data]) {
//        // Implementation pending
//    }
//    
//    static func multiRemove(keys: [Key]) {
//        // Implementation pending
//    }
//}
//
//// MARK: - Implementations
//
//class StandardTag: Tag {
//    var name: String
//    var value: String
//    var store: DataStoreProtocol
//    
//    init(name: String, value: String, store: DataStoreProtocol = FKR.defaultTagStore) {
//        self.name = name
//        self.value = value
//        self.store = store
//    }
//    
//    func increment() {
//        // Implementation pending
//    }
//}
//
//class StandardKey: Key {
//    var name: String
//    var tags: [Tag]
//    var store: DataStoreProtocol
//    
//    init(name: String, tags: [Tag], store: DataStoreProtocol = FKR.defaultRecordStore) {
//        self.name = name
//        self.tags = tags
//        self.store = store
//    }
//    
//    func getKeyString() -> String {
//        // Implementation pending
//        return ""
//    }
//}
//
//class KeyRingStandard: KeyRing {
//    var defaultStore: DataStoreProtocol
//    var defaultTags: [Tag]
//    
//    init(defaultStore: DataStoreProtocol, defaultTags: [Tag]) {
//        self.defaultStore = defaultStore
//        self.defaultTags = defaultTags
//    }
//    
//    func key(name: String, tags: [Tag]? = nil, store: DataStoreProtocol? = nil) -> Key {
//        let combinedTags = (tags ?? []) + defaultTags
//        let effectiveStore = store ?? defaultStore
//        return StandardKey(name: name, tags: combinedTags, store: effectiveStore)
//    }
//}
//
//// MARK: - Placeholder Types
//
//class Telemetry {
//    // Implementation pending
//}

//
//extension SettingsProtocol {
//    static func merge(_ lhs: Self?, with rhs: Self?) -> Self? {
//        guard let lhs = lhs else {
//            return rhs
//        }
//        
//        guard let rhs = rhs else {
//            return lhs
//        }
//        
//        var lhsDict = lhs as [String: Any?]
//        let rhsDict = rhs as [String: Any?]
//
//        
//        
//        var mergedDictionary = Self.`as`(instance: lhs)
//        let rhsDictionary = Self.`as`(instance: rhs)
//        
//        for (key, value) in rhsDictionary {
//            mergedDictionary[key] = value
//        }
//        
//        return Self.from(dictionary: mergedDictionary)
//    }
//    
//    func merge(with other: Self?) -> Self {
//        guard let other = other else {
//            return self
//        }
//        
//        var mergedDictionary = Self.`as`(instance: self)
//        let otherDictionary = Self.`as`(instance: other)
//        
//        for (key, value) in otherDictionary {
//            mergedDictionary[key] = value
//        }
//        
//        return Self.from(dictionary: mergedDictionary)
//    }
//}
//
//struct NSCacheConfiguration : ConfigurationProtocol {
//    var countLimit: Int?
//    var totalCostLimit: Int?
//    var evictsObjectsWithDiscardedContent: Bool?
//    var name: String?
//    var objectClass: AnyClass?
//    var delegate: NSCacheDelegate?
//}
//
//
//
//class NSCacheStore {
//    
//}
//
//
//protocol DataStoreProtocol2 : ReportSelf {
//    associatedtype Configuration: ConfigurationProtocol
//    associatedtype RuntimeSettings: RuntimeSettingsProtocol
//    associatedtype Options: DataStoreOptions
//    associatedtype RequestOutcome: RequestOutcomeProtocol
//    
//    typealias MultiGetKeyPair = RecordHandleProtocol // and ptions
//    typealias MultiSetKeyPair = (RecordHandleProtocol, Serializable?) // and options
//    typealias MultiClearKeyPair = RecordHandleProtocol // and options
//    typealias MultiGetResponseKeyPair = (RecordHandleProtocol, Serializable?) // this instead of Serializable we should have a struct indicating (Type, Data?)
//    
//    var config: Configuration {get}
//    var runtime: RuntimeSettings {get set}
//    
//    func get<T: Serializable>(_ key: RecordHandleProtocol, options: Options.GetOptions?) -> T?
//    func set(_ key: RecordHandleProtocol, record: Serializable?,  options: Options.SetOptions?) -> RequestOutcome
//    func clear(_ key: RecordHandleProtocol, options: Options.ClearOptions?) -> RequestOutcome
//    
//    func multiGet(keys: [MultiGetKeyPair], options: Options.MultiGetOptions?) -> [MultiGetResponseKeyPair]
//    func multiSet(_ keys: [MultiSetKeyPair],  options: Options.MultiSetOptions?) -> RequestOutcome
//    func multiClear(_ keys: [MultiClearKeyPair], options: Options.MultiClearOptions?) -> RequestOutcome
//    
//}
