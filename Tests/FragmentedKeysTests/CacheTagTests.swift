import XCTest
@testable import FragmentedKeys

// Your CacheTag and BaseTag code goes here.

class CacheTagTests: XCTestCase {

    // Test that the signature is correctly generated.
    func testSignatureGeneration() {
        let tagName = "TestTag"
        let subject = "User123"
        let cacheTag = CacheTag(name: tagName, subject: subject)
        
        let expectedSignature = "\(tagName)::\(subject)"
        XCTAssertEqual(cacheTag.signature(), expectedSignature, "CacheTag signature should match expected signature.")
    }

    // Test the versioned identifier.
    func testVersionedIdentifier() {
        let tagName = "TestTag"
        let subject = "User123"
        let version = 1
        let cacheTag = CacheTag(name: tagName, subject: subject, version: version)
        
        let expectedVersioned = "\(tagName)::\(subject)@\(version)"
        XCTAssertEqual(cacheTag.versioned(), expectedVersioned, "CacheTag versioned identifier should match expected identifier.")
    }

    // Test that version increments correctly.
    func testVersionIncrement() {
        let tagName = "TestTag"
        let cacheTag = CacheTag(name: tagName)

        let initialVersion = cacheTag.version
        cacheTag.increment()
        let incrementedVersion = cacheTag.version
        
        XCTAssertNotEqual(initialVersion, incrementedVersion, "Version should not be equal after increment.")
        XCTAssertEqual(incrementedVersion, initialVersion + 1, "Incremented version should be one more than initial version.")
    }
    
    // Test the versioned identifier after incrementing the version.
    func testVersionedIdentifierAfterIncrement() {
        let tagName = "TestTag"
        let cacheTag = CacheTag(name: tagName)
        
        cacheTag.increment() // Increment the version
        let version = cacheTag.version
        
        let expectedVersioned = "\(tagName)@\(version)"
        XCTAssertEqual(cacheTag.versioned(), expectedVersioned, "CacheTag versioned identifier should match incremented version.")
    }

}
