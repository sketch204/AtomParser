import XCTest
@testable import AtomXML
@testable import AtomParser
import TestUtils

final class LinkParsingTests: XCTestCase {
    func test_parses() throws {
        let xml = AtomXMLNode(name: "link", attributes: ["href": sampleUrlString])
        
        let link = try Link(xmlNode: xml)
        let expectedLink = Link(url: sampleURL, relationship: nil, type: nil, title: nil, length: 0)
        
        XCTAssertEqual(link, expectedLink)
    }
    
    func test_doesNotParseInvalidNode() throws {
        let xml = AtomXMLNode(name: "not link")
        
        XCTAssertThrowsError(try Link(xmlNode: xml))
    }
    
    func test_doesNotParse_whenMissingHRef() throws {
        let xml = AtomXMLNode(name: "link")
        
        XCTAssertThrowsError(try Link(xmlNode: xml))
    }
    
    func test_parsesRelationship() throws {
        let xml = AtomXMLNode(
            name: "link",
            attributes: [
                "href": sampleUrlString,
                "rel": "alternate",
            ]
        )
        
        let link = try Link(xmlNode: xml)
        let expectedLink = Link(url: sampleURL, relationship: .alternate, type: nil, title: nil, length: 0)
        
        XCTAssertEqual(link, expectedLink)
    }
    
    func test_parsesType() throws {
        let xml = AtomXMLNode(
            name: "link",
            attributes: [
                "href": sampleUrlString,
                "type": "html",
            ]
        )
        
        let link = try Link(xmlNode: xml)
        let expectedLink = Link(url: sampleURL, relationship: nil, type: "html", title: nil, length: 0)
        
        XCTAssertEqual(link, expectedLink)
    }
    
    func test_parsesTitle() throws {
        let xml = AtomXMLNode(
            name: "link",
            attributes: [
                "href": sampleUrlString,
                "title": "Title",
            ]
        )
        
        let link = try Link(xmlNode: xml)
        let expectedLink = Link(url: sampleURL, relationship: nil, type: nil, title: "Title", length: 0)
        
        XCTAssertEqual(link, expectedLink)
    }
    
    func test_parsesLength() throws {
        let xml = AtomXMLNode(
            name: "link",
            attributes: [
                "href": sampleUrlString,
                "length": "10",
            ]
        )
        
        let link = try Link(xmlNode: xml)
        let expectedLink = Link(url: sampleURL, relationship: nil, type: nil, title: nil, length: 10)
        
        XCTAssertEqual(link, expectedLink)
    }
}

extension Link: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url == rhs.url
        && lhs.relationship == rhs.relationship
        && lhs.type == rhs.type
        && lhs.title == rhs.title
        && lhs.length == rhs.length
    }
}
