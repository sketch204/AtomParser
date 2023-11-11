import XCTest
@testable import AtomXML
@testable import RSSParser

final class ImageParsingTests: XCTestCase {
    func test_whenAllRequiredFieldsProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
            ]
        )
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(
            link: URL(string: "https://hello.mock")!,
            title: "A title",
            url: URL(string: "https://hello.mock")!,
            description: nil,
            width: nil,
            height: nil
        )
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_whenLinkMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
    
    func test_whenTitleMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
    
    func test_whenUrlMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
    
    func test_whenDescriptionProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
                AtomXMLNode(name: "description", content: "a description"),
            ]
        )
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(
            link: URL(string: "https://hello.mock")!,
            title: "A title",
            url: URL(string: "https://hello.mock")!,
            description: "a description",
            width: nil,
            height: nil
        )
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_whenWidthProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
                AtomXMLNode(name: "width", content: "98"),
            ]
        )
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(
            link: URL(string: "https://hello.mock")!,
            title: "A title",
            url: URL(string: "https://hello.mock")!,
            description: nil,
            width: 98,
            height: nil
        )
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_whenHeightProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
                AtomXMLNode(name: "height", content: "78"),
            ]
        )
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(
            link: URL(string: "https://hello.mock")!,
            title: "A title",
            url: URL(string: "https://hello.mock")!,
            description: nil,
            width: nil,
            height: 78
        )
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_whenLinkUrlIsInvalid_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: ""),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
    
    func test_whenUrlIsInvalid_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "image",
            children: [
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: ""),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "not image",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "url", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
}

extension Image: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.link == rhs.link
        && lhs.title == rhs.title
        && lhs.url == rhs.url
        && lhs.description == rhs.description
        && lhs.width == rhs.width
        && lhs.height == rhs.height
    }
}