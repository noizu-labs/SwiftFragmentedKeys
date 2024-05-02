import XCTest
@testable import FragmentedKeys

class NSCacheTests: XCTestCase {

    struct Foo : Serializable {
        var bop: String
    }
    
    
    func testSetGet() {
        let ds = NSCacheStore(config: NSCacheStoreConfig(name: "Apple"))
        let f = Foo(bop: "Apple")
        ds.set("Anna", to: f)
        guard let sut: Foo = ds.get("Anna") else {
            XCTFail("Get from Cache Failed")
            return
        }
        XCTAssertEqual(sut.bop, "Apple")
        
    }
    
    
    func testExpiry() {
        let ds = NSCacheStore(config: NSCacheStoreConfig(name: "Apple"))
        let f = Foo(bop: "Apple")
        ds.set("Anna", to: f, options: SetOptions(ttl: .expiry(0.0001)))
        usleep(2)
        let sut: Foo? = ds.get("Anna")
        XCTAssertNil(sut)
    }
    
}
