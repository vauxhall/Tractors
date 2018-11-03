import XCTest
@testable import Tractors

class TestDelegate:XCTestCase {
    private var catalog:Catalog!
    private var delegate:MockDelegate!
    
    override func setUp() {
        catalog = Catalog()
        delegate = MockDelegate()
        catalog.delegate = delegate
    }
    
    func testNotifyOnTractorsUpdated() {
        let expect = expectation(description:String())
        delegate.onTractorsUpdated = {
            XCTAssertEqual(Thread.main, Thread.current)
            expect.fulfill()
        }
        DispatchQueue.global(qos:.background).async { self.catalog.update(drivers:[])  }
        waitForExpectations(timeout:1)
    }
}
