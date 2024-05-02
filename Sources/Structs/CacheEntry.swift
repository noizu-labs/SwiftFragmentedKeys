//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation

struct CacheEntry {
    var entry: Serializable?
    var storedAt: TimeInterval
    var ttl: TTL
    init(entry: Serializable?, ttl: TTL = .infinity) {
        self.entry = entry
        self.ttl = ttl
        self.storedAt = Date().timeIntervalSince1970
    }
}
