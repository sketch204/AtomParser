import XCTest
@testable import AtomXML
@testable import AtomParser
import TestUtils

final class GUIDParsingTests: XCTestCase {
    func test_whenIsPermaLinkOmitted_parses() throws {
        let xml = AtomXMLNode(name: "guid", content: "https://hello.mock")
        
        let guid = try GUID(xmlNode: xml)
        let expectedGuid = GUID(contents: "https://hello.mock", isPermaLink: true)
        
        XCTAssertEqual(guid, expectedGuid)
    }
    
    func test_whenIsPermaLinkTrueProvided_parses() throws {
        let xml = AtomXMLNode(name: "guid", attributes: ["isPermaLink": "true"], content: "https://hello.mock")
        
        let guid = try GUID(xmlNode: xml)
        let expectedGuid = GUID(contents: "https://hello.mock", isPermaLink: true)
        
        XCTAssertEqual(guid, expectedGuid)
    }
    
    func test_whenIsPermaLinkNotTrueProvided_urlAvailable() throws {
        let xml = AtomXMLNode(name: "guid", attributes: ["isPermaLink": "dsa"], content: "article1")
        
        let guid = try GUID(xmlNode: xml)
        let expectedGuid = GUID(contents: "article1", isPermaLink: false)
        
        XCTAssertEqual(guid, expectedGuid)
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(name: "not guid", attributes: ["isPermaLink": "true"], content: "https://hello.mock")
        
        XCTAssertThrowsError(try GUID(xmlNode: xml))
    }
}

extension GUID: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.contents == rhs.contents
        && lhs.isPermaLink == rhs.isPermaLink
    }
}
