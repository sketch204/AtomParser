import XCTest
@testable import AtomXML
@testable import AtomParser
import TestUtils

final class CategoryParsingTests: XCTestCase {
    func test_whenCategoryProvided_parses() throws {
        let xml = AtomXMLNode(name: "category", content: "A category")
        
        let category = try RSSCategory(xmlNode: xml)
        let expectedCategory = RSSCategory(name: "A category", domain: nil)
        
        XCTAssertEqual(category, expectedCategory)
    }
    
    func test_whenCategoryWithDomainProvided_parses() throws {
        let xml = AtomXMLNode(name: "category", attributes: ["domain": "some domain"], content: "A category")
        
        let category = try RSSCategory(xmlNode: xml)
        let expectedCategory = RSSCategory(name: "A category", domain: "some domain")
        
        XCTAssertEqual(category, expectedCategory)
    }
    
    func test_whenInvalidTagProvided_doesNotParse() throws {
        let xml = AtomXMLNode(name: "not a category")
        
        XCTAssertThrowsError(try RSSCategory(xmlNode: xml))
    }
}

extension AtomParser.RSSCategory: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
        && lhs.domain == rhs.domain
    }
}
