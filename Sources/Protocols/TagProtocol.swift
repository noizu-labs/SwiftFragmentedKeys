//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation


protocol TagProtocol : RecordHandle {
    var store: (any DataStore)? {get}
    func tagFragment() throws -> String
    func tagVersion() throws -> TagVersion
}
