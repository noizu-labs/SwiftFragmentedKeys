//
//  File.swift
//  
//
//  Created by Keith Brings on 4/24/24.
//

import Foundation


protocol Telemetry {
    
}

class StandardTelemetry : Telemetry {
    
}

class FKM {
    static var _instance: FKM?
    static var instance: FKM {
        get throws {
            guard let x = _instance else {
                throw FragmentedKeyError.error(message: "FKM Not Initialized")
            }
            return x
        }
        
    }
    static func initialize(
        tagStore: (any DataStore) = NSCacheStore(),
        recordStore: (any DataStore) = NSCacheStore(),
        telemetry: (any Telemetry) = StandardTelemetry()
    ) throws -> Void {
        guard nil == _instance else {
            throw FragmentedKeyError.error(message: "Already Initialized")
        }
        _instance = FKM(tagStore: tagStore, recordStore: recordStore, telemetry: telemetry)
    }

    let tagStore: any DataStore
    let recordStore: any DataStore
    let telemetry: any Telemetry
    
    private init(
        tagStore: (any DataStore),
        recordStore: (any DataStore),
        telemetry: (any Telemetry)) {
            self.tagStore = tagStore
            self.recordStore = recordStore
            self.telemetry = telemetry
    }
    
}
