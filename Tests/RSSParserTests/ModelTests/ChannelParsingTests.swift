import XCTest
@testable import AtomXML
@testable import RSSParser

final class ChannelParsingTests: XCTestCase {
    func test_whenRequiredFieldsProvider_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenTitleMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Channel(xmlNode: xml))
    }
    
    func test_whenDescriptionMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Channel(xmlNode: xml))
    }
    
    func test_whenLinkMissing_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
            ]
        )
        
        XCTAssertThrowsError(try Channel(xmlNode: xml))
    }
    
    func test_whenCategoryProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "category", content: "A category"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [
                Category(name: "A category", domain: nil),
            ],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenMultipleCategoriesProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "category", content: "A category"),
                AtomXMLNode(name: "category", content: "Another category"),
                AtomXMLNode(name: "category", content: "A better category"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [
                Category(name: "A category", domain: nil),
                Category(name: "Another category", domain: nil),
                Category(name: "A better category", domain: nil),
            ],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenCopyrightProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "copyright", content: "A copyright"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: "A copyright",
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenGeneratorProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "generator", content: "A generator"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: "A generator",
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenImageProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "image", children: [
                    AtomXMLNode(name: "link", content: "https://hello.mock"),
                    AtomXMLNode(name: "title", content: "A title"),
                    AtomXMLNode(name: "url", content: "https://hello.mock"),
                ]),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: Image(
                link: URL(string: "https://hello.mock")!,
                title: "A title",
                url: URL(string: "https://hello.mock")!,
                description: nil,
                width: nil,
                height: nil
            ),
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenLanguageProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "language", content: "en-ca"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: "en-ca",
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenLastBuildDateProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "lastBuildDate", content: "Thu, 15 Jun 2023 10:54:15 +0200"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: try parseDate("Thu, 15 Jun 2023 10:54:15 +0200"),
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenManagingEditorProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "managingEditor", content: "example@domain.com"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: "example@domain.com",
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenPubDateProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "pubDate", content: "Thu, 15 Jun 2023 10:54:15 +0200"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: try parseDate("Thu, 15 Jun 2023 10:54:15 +0200"),
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenSkipDaysProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "skipDays", children: [
                    AtomXMLNode(name: "day", content: "Monday"),
                    AtomXMLNode(name: "day", content: "Wednesday")
                ]),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [.monday, .wednesday],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenSkipHoursProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "skipHours", children: [
                    AtomXMLNode(name: "hour", content: "4"),
                    AtomXMLNode(name: "hour", content: "5"),
                    AtomXMLNode(name: "hour", content: "6"),
                ]),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: [4, 5, 6]),
            ttl: nil,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenTtlProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "ttl", content: "120"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: 120,
            webMaster: nil,
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenWebMasterProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(name: "webMaster", content: "example@domain.com"),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: "example@domain.com",
            items: []
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenItemProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                AtomXMLNode(
                    name: "item",
                    children: [
                        AtomXMLNode(name: "title", content: "A title"),
                    ]
                )
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: [
                Item(
                    title: "A title",
                    description: nil,
                    guid: nil,
                    link: nil,
                    author: nil,
                    categories: [],
                    commentsUrl: nil,
                    pubDate: nil
                )
            ]
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenMultipleItemsProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
                
                AtomXMLNode(
                    name: "item",
                    children: [
                        AtomXMLNode(name: "title", content: "An item"),
                    ]
                ),
                AtomXMLNode(
                    name: "item",
                    children: [
                        AtomXMLNode(name: "title", content: "Another item"),
                    ]
                ),
            ]
        )
        
        let channel = try Channel(xmlNode: xml)
        let expectedChannel = Channel(
            title: "A title",
            description: "A description",
            link: URL(string: "https://hello.mock")!,
            categories: [],
            copyright: nil,
            generator: nil,
            image: nil,
            language: nil,
            lastBuildDate: nil,
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: [
                Item(
                    title: "An item",
                    description: nil,
                    guid: nil,
                    link: nil,
                    author: nil,
                    categories: [],
                    commentsUrl: nil,
                    pubDate: nil
                ),
                Item(
                    title: "Another item",
                    description: nil,
                    guid: nil,
                    link: nil,
                    author: nil,
                    categories: [],
                    commentsUrl: nil,
                    pubDate: nil
                )
            ]
        )
        
        XCTAssertEqual(channel, expectedChannel)
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(
            name: "not channel",
            children: [
                AtomXMLNode(name: "title", content: "A title"),
                AtomXMLNode(name: "description", content: "A description"),
                AtomXMLNode(name: "link", content: "https://hello.mock"),
            ]
        )
        
        XCTAssertThrowsError(try Channel(xmlNode: xml))
    }
}

extension Channel: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.link == rhs.link
        && lhs.categories == rhs.categories
        && lhs.copyright == rhs.copyright
        && lhs.generator == rhs.generator
        && lhs.image == rhs.image
        && lhs.language == rhs.language
        && lhs.lastBuildDate == rhs.lastBuildDate
        && lhs.managingEditor == rhs.managingEditor
        && lhs.pubDate == rhs.pubDate
        && lhs.skipDays == rhs.skipDays
        && lhs.skipHours == rhs.skipHours
        && lhs.ttl == rhs.ttl
        && lhs.webMaster == rhs.webMaster
        && lhs.items == rhs.items
    }
}
