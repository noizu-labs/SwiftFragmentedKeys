//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation

class Key : KeyProtocol {
    var tags: [TagProtocol]
    
    func handleName() -> String {
        /// @TODO MultiFetch
        /// loop over tags, group by store.
        /// for store get tag
        return "wip"
    }
    
    init(tags: [TagProtocol]) {
        self.tags = tags
    }
}
