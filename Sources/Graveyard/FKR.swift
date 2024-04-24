////
////  File.swift
////  
////
////  Created by Keith Brings on 4/24/24.
////
//
//import Foundation
//
//
//
//protocol Key {
//    func dummy() -> Void;
//    
//}
//
//protocol Tag {
//    func dummy() -> Void;
//}
//
//protocol CacheStore {
//    func dummy() -> Void;
//}
//
//struct Configuration {
//    //------
//    // Registry
//    //------
//    private static var registry: [String:Configuration] = [:];
//
//    private init(tagStore: CacheStore, recordStore: CacheStore) {
//        self.tagStore = tagStore;
//        self.recordStore = recordStore;
//    }
//    
//    public static func instance(name: String) -> Configuration {
//        guard let config = registry[name] else {
//            fatalError("Configuration Instance \(name) has not been set.")
//        }
//        return config;
//    }
//    public static func registerInstance(name: String, tagStore: CacheStore, recordStore: CacheStore) -> Configuration {
//        guard registry[name] == nil else {
//            fatalError("Configuration Instance \(name) already defined.");
//        }
//        let instance = Configuration(tagStore: tagStore, recordStore: recordStore);
//        registry[name] = instance;
//        return instance;
//    }
//
//    // Members
//    public let tagStore: CacheStore;
//    public let recordStore: CacheStore;
//}
//
//class FKR {
//
//    //---------------------------
//    // Statics
//    //---------------------------
//    
//    //------
//    // Singleton Instance
//    //------
//    private static var _shared: FKR?
//    static let cacheManager: FKR = {
//        guard let manager = _shared else {
//            //
//            // FKR.initialize(configuration: Configuration)
//            //
//            fatalError("FragmentedKeyManager has not been initilized.")
//        }
//        return manager
//    }()
//
//    public static func initialize(config: Configuration) {
//        guard _shared == nil else {
//            fatalError("Default Configuration Already Set.")
//        }
//        self._shared = FKR(config: config);
//    }
//
//    // Vars
//    private var config: Configuration;
//    
//    public init(config: Configuration) {
//        self.config = config;
//    }
//    
//    
//    
//    
//    
//}
