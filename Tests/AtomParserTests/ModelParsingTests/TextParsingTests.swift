import XCTest
@testable import AtomXML
@testable import AtomParser

final class TextParsingTests: XCTestCase {
    func test_parsesWithoutContent() throws {
        let xml = AtomXMLNode(name: "title")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesWithContent() throws {
        let xml = AtomXMLNode(name: "title", content: "Content!")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "Content!")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesWithTypeAttribute() throws {
        let xml = AtomXMLNode(name: "title", attributes: ["type": "xhtml"])
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .xhtml, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesTitle() throws {
        let xml = AtomXMLNode(name: "title")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesSubtitle() throws {
        let xml = AtomXMLNode(name: "subtitle")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesSummary() throws {
        let xml = AtomXMLNode(name: "summary")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesContent() throws {
        let xml = AtomXMLNode(name: "content")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_parsesRights() throws {
        let xml = AtomXMLNode(name: "rights")
        
        let text = try Text(xmlNode: xml)
        let expectedText = Text(type: .text, content: "")
        
        XCTAssertEqual(text, expectedText)
    }
    
    func test_doesNotParsesInvalidNode() throws {
        let xml = AtomXMLNode(name: "not valid")
        
        XCTAssertThrowsError(try Text(xmlNode: xml))
    }
}

extension Text: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.type == rhs.type
        && lhs.content == rhs.content
    }
}
