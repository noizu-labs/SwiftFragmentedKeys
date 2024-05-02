//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation



protocol DataStore {
    associatedtype Config: DataStoreConfig
    
    func incrementTag(_ key: RecordHandle) -> TagVersion
    func currentTag(_ key: RecordHandle) -> TagVersion
    func get<T: Serializable>(_ key: RecordHandle) -> T?
    func set(_ key: RecordHandle, to: Serializable, options: DataStoreSetOptions?) -> Void
    func erase(_ key: RecordHandle) -> Void
    
    func multiGet(_ keys: [RecordHandle]) -> [MultiGetResponse]
}
