import XCTest
@testable import AtomXML
@testable import AtomParser
import TestUtils

final class RSSVersionParsingTests: XCTestCase {
    func test_whenVersion2_0TagProvided_parses() throws {
        let xml = AtomXMLNode(name: "rss", attributes: ["version": "2.0"])
        
        let rss = try RSSVersion(xmlNode: xml)
        
        XCTAssertEqual(rss, .v2_0)
    }
    
    func test_whenVersion0_91TagProvided_parses() throws {
        let xml = AtomXMLNode(name: "rss", attributes: ["version": "0.91"])
        
        let rss = try RSSVersion(xmlNode: xml)
        
        XCTAssertEqual(rss, .v0_91)
    }
    
    func test_whenVersion0_92TagProvided_parses() throws {
        let xml = AtomXMLNode(name: "rss", attributes: ["version": "0.92"])
        
        let rss = try RSSVersion(xmlNode: xml)
        
        XCTAssertEqual(rss, .v0_92)
    }
    
    func test_whenInvalidVersionProvided_doesNotParse() throws {
        let xml = AtomXMLNode(name: "rss", attributes: ["version": "1.93"])
        
        XCTAssertThrowsError(try RSSVersion(xmlNode: xml))
    }
}
