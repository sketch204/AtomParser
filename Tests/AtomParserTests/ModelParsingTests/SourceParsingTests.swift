import XCTest
@testable import AtomParser

final class SourceParsingTests: XCTestCase {
    func test_parses_whenAllFieldsPresent() throws {
        let xml = AtomXMLNode(
            name: "source",
            children: [
                AtomXMLNode(name: "id", content: sampleUrlString),
                AtomXMLNode(name: "title", content: "Title"),
                AtomXMLNode(name: "updated", content: sampleDateString),
            ]
        )
        
        let source = try Source(xmlNode: xml)
        let expectedSource = Source(uri: sampleURL, title: Text(type: .text, content: "Title"), updated: sampleDate)
        
        XCTAssertEqual(source, expectedSource)
    }
    
    func test_doesNotParse_whenInvalidNode() {
        let xml = AtomXMLNode(
            name: "not source",
            children: [
                AtomXMLNode(name: "id", content: sampleUrlString),
                AtomXMLNode(name: "title", content: "Title"),
                AtomXMLNode(name: "updated", content: sampleDateString),
            ]
        )
        
        XCTAssertThrowsError(try Source(xmlNode: xml))
    }
    
    func test_doesNotParse_whenIdMissing() {
        let xml = AtomXMLNode(
            name: "not source",
            children: [
                AtomXMLNode(name: "title", content: "Title"),
                AtomXMLNode(name: "updated", content: sampleDateString),
            ]
        )
        
        XCTAssertThrowsError(try Source(xmlNode: xml))
    }
    
    func test_doesNotParse_whenTitleMissing() {
        let xml = AtomXMLNode(
            name: "not source",
            children: [
                AtomXMLNode(name: "id", content: sampleUrlString),
                AtomXMLNode(name: "updated", content: sampleDateString),
            ]
        )
        
        XCTAssertThrowsError(try Source(xmlNode: xml))
    }
    
    func test_doesNotParse_whenUpdatedMissing() {
        let xml = AtomXMLNode(
            name: "not source",
            children: [
                AtomXMLNode(name: "id", content: sampleUrlString),
                AtomXMLNode(name: "title", content: "Title"),
            ]
        )
        
        XCTAssertThrowsError(try Source(xmlNode: xml))
    }
}


extension Source: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uri == rhs.uri
        && lhs.title == rhs.title
        && lhs.updated == rhs.updated
    }
}
