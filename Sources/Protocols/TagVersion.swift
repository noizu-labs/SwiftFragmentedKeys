//
//  File.swift
//  
//
//  Created by Keith Brings on 5/2/24.
//

import Foundation



protocol TagVersion : Serializable {
    func incrementTagVersion() -> Self
}

extension Int: TagVersion {
    func incrementTagVersion() -> Self {
        return self + 1
    }
}

extension String: TagVersion {
    func incrementTagVersion() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "-(\\d+)$", options: [])
            let range = NSRange(location: 0, length: self.utf16.count)
            
            if let match = regex.firstMatch(in: self, options: [], range: range) {
                let lastNumberRange = match.range(at: 1)
                if let swiftRange = Range(lastNumberRange, in: self) {
                    let lastNumber = Int(self[swiftRange])!
                    let incrementedNumber = lastNumber + 1
                    return self.replacingCharacters(in: swiftRange, with: String(incrementedNumber))
                }
            }
        } catch {
            
        }
        // If the string does not end with a number, append "-1"
        return self + "-1"
    }
}

extension UUID: TagVersion {
    func incrementTagVersion() -> UUID {
        return UUID()
    }
}
