//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation


class FixedTag : TagProtocol {
    private let name: String
    private let subject: String?
    private let version: TagVersion
    
    init(name: String, subject: Taggable? = nil, version: TagVersion = 1) {
        self.name = name
        if let s = subject {
            self.subject = s.tagHandle()
        } else {
            self.subject = nil
        }
        self.version = version
    }
    
    var store: (any DataStore)? {
        get {
            return nil
        }
    }
    
    func handleName() -> String {
        if let subject = self.subject {
            return "\(self.name).\(subject)"
        } else {
            return self.name
        }
    }
    func tagFragment() -> String {
        return "\(handleName())@\(version)"
    }
    func tagVersion() -> TagVersion {
        return self.version
    }
}

