import XCTest
@testable import AtomXML
@testable import AtomParser
import TestUtils

final class ItemParsingTests: XCTestCase {
    func test_whenTitleProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: nil,
            categories: [],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenDescriptionProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "description", content: "A description"),
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: nil,
            description: "A description",
            guid: nil,
            link: nil,
            author: nil,
            categories: [],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenTitleAndDescriptionMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "guid", content: "https://hello.mock")
            ]
        )
        
        XCTAssertThrowsError(try Item(xmlNode: xml))
    }
    
    func test_whenGuidProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "guid", content: "https://hello.mock")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: GUID(contents: "https://hello.mock", isPermaLink: true),
            link: nil,
            author: nil,
            categories: [],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenLinkProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "link", content: "https://hello.mock")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: URL(string: "https://hello.mock"),
            author: nil,
            categories: [],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenAuthorProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "author", content: "Some Dude")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: "Some Dude",
            categories: [],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenCategoryProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "category", content: "A category")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: nil,
            categories: [
                RSSCategory(name: "A category", domain: nil),
            ],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenMultipleCategoriesProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "category", content: "A category"),
                AtomXMLNode(name: "category", content: "Another category"),
                AtomXMLNode(name: "category", content: "A better category"),
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: nil,
            categories: [
                RSSCategory(name: "A category", domain: nil),
                RSSCategory(name: "Another category", domain: nil),
                RSSCategory(name: "A better category", domain: nil),
            ],
            commentsUrl: nil,
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenCommentsProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "comments", content: "https://hello.mock")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: nil,
            categories: [],
            commentsUrl: URL(string: "https://hello.mock"),
            pubDate: nil
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenPubDateProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "item",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "pubDate", content: "Tue, 17 Oct 2023 18:35:48 +0000")
            ]
        )
        
        let item = try Item(xmlNode: xml)
        let expectedItem = Item(
            title: "A title",
            description: nil,
            guid: nil,
            link: nil,
            author: nil,
            categories: [],
            commentsUrl: nil,
            pubDate: try parseRssDate("Tue, 17 Oct 2023 18:35:48 +0000")
        )
        
        XCTAssertEqual(item, expectedItem)
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "not item",
            children: [
                AtomXMLNode(name: "guid", content: "https://hello.mock")
            ]
        )
        
        XCTAssertThrowsError(try Item(xmlNode: xml))
    }
}

extension Item: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.guid == rhs.guid
        && lhs.link == rhs.link
        && lhs.author == rhs.author
        && lhs.categories == rhs.categories
        && lhs.commentsUrl == rhs.commentsUrl
        && lhs.pubDate == rhs.pubDate
    }
}
