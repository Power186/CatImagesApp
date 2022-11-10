import XCTest
@testable import CatImages

final class CatModelCodableTests: XCTestCase {
    
    var sut: Cat!
    var testJSON: JSONResponseTests!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Cat()
        testJSON = JSONResponseTests()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_CodableCatModel() throws {
        let decoded = try JSONDecoder().decode([Cat].self,
                                               from: testJSON.catModelResponse)
        XCTAssertNoThrow(decoded, "Cat Array should not throw errors decoding")
        
        decoded.forEach {
            XCTAssertEqual($0.catId, "Rn6xqsiHb9B7qgLw")
        }
    }

}
