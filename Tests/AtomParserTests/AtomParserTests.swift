import XCTest
@testable import AtomParser

final class AtomParserTests: XCTestCase {
    let sampleXml = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
        <generator uri="https://jekyllrb.com/" version="4.3.2">Jekyll</generator>
        <link href="https://inalgotov.com/feed.xml" rel="self" type="application/atom+xml" />
        <link href="https://inalgotov.com/" rel="alternate" type="text/html" />
        <updated>\(sampleDateString)</updated>
        <id>https://inalgotov.com/feed.xml</id>
        <title type="html">Inal’s Gotov</title>
        <subtitle>Inal's personal webpage</subtitle>
        <author>
            <name>Inal Gotov</name>
        </author>
        <entry>
            <title type="html">How to use Tables in SwiftUI</title>
            <link href="https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui.html" rel="alternate" type="text/html" title="How to use Tables in SwiftUI" />
            <published>\(sampleDateString)</published>
            <updated>\(sampleDateString)</updated>
            <id>https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui</id>
            <content type="html" xml:base="https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui.html">
                In this article we’re going to take a quick look at how tables are setup and used in SwiftUI.
            </content>
            <author>
                <name>Inal Gotov</name>
            </author>
            <category term="SwiftUI" />
            <summary type="html">
                In this article we&apos;re going to take a quick look at how tables are setup and used in SwiftUI.
            </summary>
        </entry>
        <entry>
            <title type="html">From C to Swift - Part 1</title>
            <link href="https://inalgotov.com/2023/07/15/from-c-to-swift-pt1.html" rel="alternate" type="text/html" title="From C to Swift - Part 1" />
            <published>\(sampleDateString)</published>
            <updated>\(sampleDateString)</updated>
            <id>https://inalgotov.com/2023/07/15/from-c-to-swift-pt1</id>
            <content type="html" xml:base="https://inalgotov.com/2023/07/15/from-c-to-swift-pt1.html">
                In this article I will walk you through the steps required to set up a C library as a SwiftPM package. This will allow you to use C code within a Swift project. I will then also show you how to use said C code from Swift, as well as how to make it more Swift-friendly.
            </content>
            <author>
                <name>Inal Gotov</name>
            </author>
            <category term="swift" />
            <category term="swiftpm" />
            <category term="c" />
            <summary type="html">
                In this article I will walk you through the steps required to set up a C library as a SwiftPM package. This will allow you to use C code within a Swift project. I will then also show you how to use said C code from Swift, as well as how to make it more Swift-friendly.
            </summary>
        </entry>
        <entry>
            <title type="html">From C to Swift - Part 2</title>
            <link href="https://inalgotov.com/2023/07/15/from-c-to-swift-pt2.html" rel="alternate" type="text/html" title="From C to Swift - Part 2" />
            <published>\(sampleDateString)</published>
            <updated>\(sampleDateString)</updated>
            <id>https://inalgotov.com/2023/07/15/from-c-to-swift-pt2</id>
            <content type="html" xml:base="https://inalgotov.com/2023/07/15/from-c-to-swift-pt2.html">
                In part 1 of this series we looked at how we can integrate a C library with SwiftPM such that we can import it into our code. In this article, we will be taking a look at how to actually use the C code, and what the edge cases of using C code in Swift are. If you missed the first part, I highly recommend you give it a read.
            </content>
            <author>
                <name>Inal Gotov</name>
            </author>
            <category term="swift" />
            <category term="swiftpm" />
            <category term="c" />
            <summary type="html">
                In part 1 of this series we looked at how we can integrate a C library with SwiftPM such that we can import it into our code. In this article, we will be taking a look at how to actually use the C code, and what the edge cases of using C code in Swift are. If you missed the first part, I highly recommend you give it a read.
            </summary>
        </entry>
        <entry>
            <title type="html">Big bag of Xcode tips and tricks</title>
            <link href="https://inalgotov.com/2023/05/01/xcode-bag-of-trick.html" rel="alternate" type="text/html" title="Big bag of Xcode tips and tricks" />
            <published>\(sampleDateString)</published>
            <updated>\(sampleDateString)</updated>
            <id>https://inalgotov.com/2023/05/01/xcode-bag-of-trick</id>
            <content type="html" xml:base="https://inalgotov.com/2023/05/01/xcode-bag-of-trick.html">
                I’ve been a developer for a number of years now. Primarily iOS. Over the years I’ve learned to use Xcode quite efficiently. I won’t claim to now all the ins and outs of it but I do consider myself to know more than most. Below is a list of my learnings. Perhaps you’ll find them useful.
            </content>
            <author>
                <name>Inal Gotov</name>
            </author>
            <category term="xcode" />
            <summary type="html">
                I’ve been a developer for a number of years now. Primarily iOS. Over the years I’ve learned to use Xcode quite efficiently. I won’t claim to now all the ins and outs of it but I do consider myself to know more than most. Below is a list of my learnings. Perhaps you’ll find them useful.
            </summary>
        </entry>
    </feed>
    """
    
    let expectedFeed = Feed(
        uri: URL(string: "https://inalgotov.com/feed.xml")!,
        title: Text(type: .html, content: "Inal’s Gotov"),
        updated: sampleDate,
        entries: [
            Entry(
                uri: URL(string: "https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui")!,
                title: Text(type: .html, content: "How to use Tables in SwiftUI"),
                updated: sampleDate,
                authors: [
                    Person(name: "Inal Gotov", uri: nil, email: nil)
                ],
                content: .embedded(Text(type: .html, content: "In this article we’re going to take a quick look at how tables are setup and used in SwiftUI.")),
                links: [
                    Link(
                        href: .absolute(URL(string: "https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui.html")!),
                        relationship: .alternate,
                        type: "text/html",
                        title: "How to use Tables in SwiftUI",
                        length: 0
                    ),
                ],
                summary: Text(type: .html, content: "In this article we&apos;re going to take a quick look at how tables are setup and used in SwiftUI."),
                categories: [
                    AtomCategory(term: "SwiftUI", scheme: nil, label: nil),
                ],
                contributors: [],
                published: sampleDate,
                rights: nil,
                source: nil
            ),
            Entry(
                uri: URL(string: "https://inalgotov.com/2023/07/15/from-c-to-swift-pt1")!,
                title: Text(type: .html, content: "From C to Swift - Part 1"),
                updated: sampleDate,
                authors: [
                    Person(name: "Inal Gotov", uri: nil, email: nil)
                ],
                content: .embedded(Text(type: .html, content: "In this article I will walk you through the steps required to set up a C library as a SwiftPM package. This will allow you to use C code within a Swift project. I will then also show you how to use said C code from Swift, as well as how to make it more Swift-friendly.")),
                links: [
                    Link(
                        href: .absolute(URL(string: "https://inalgotov.com/2023/07/15/from-c-to-swift-pt1.html")!),
                        relationship: .alternate,
                        type: "text/html",
                        title: "From C to Swift - Part 1",
                        length: 0
                    ),
                ],
                summary: Text(type: .html, content: "In this article I will walk you through the steps required to set up a C library as a SwiftPM package. This will allow you to use C code within a Swift project. I will then also show you how to use said C code from Swift, as well as how to make it more Swift-friendly."),
                categories: [
                    AtomCategory(term: "swiftpm", scheme: nil, label: nil),
                    AtomCategory(term: "swift", scheme: nil, label: nil),
                    AtomCategory(term: "c", scheme: nil, label: nil),
                ],
                contributors: [],
                published: sampleDate,
                rights: nil,
                source: nil
            ),
            Entry(
                uri: URL(string: "https://inalgotov.com/2023/07/15/from-c-to-swift-pt2")!,
                title: Text(type: .html, content: "From C to Swift - Part 2"),
                updated: sampleDate,
                authors: [
                    Person(name: "Inal Gotov", uri: nil, email: nil)
                ],
                content: .embedded(Text(type: .html, content: "In part 1 of this series we looked at how we can integrate a C library with SwiftPM such that we can import it into our code. In this article, we will be taking a look at how to actually use the C code, and what the edge cases of using C code in Swift are. If you missed the first part, I highly recommend you give it a read.")),
                links: [
                    Link(
                        href: .absolute(URL(string: "https://inalgotov.com/2023/07/15/from-c-to-swift-pt2.html")!),
                        relationship: .alternate,
                        type: "text/html",
                        title: "From C to Swift - Part 2",
                        length: 0
                    ),
                ],
                summary: Text(type: .html, content: "In part 1 of this series we looked at how we can integrate a C library with SwiftPM such that we can import it into our code. In this article, we will be taking a look at how to actually use the C code, and what the edge cases of using C code in Swift are. If you missed the first part, I highly recommend you give it a read."),
                categories: [
                    AtomCategory(term: "swiftpm", scheme: nil, label: nil),
                    AtomCategory(term: "swift", scheme: nil, label: nil),
                    AtomCategory(term: "c", scheme: nil, label: nil),
                ],
                contributors: [],
                published: sampleDate,
                rights: nil,
                source: nil
            ),
            Entry(
                uri: URL(string: "https://inalgotov.com/2023/05/01/xcode-bag-of-trick")!,
                title: Text(type: .html, content: "Big bag of Xcode tips and tricks"),
                updated: sampleDate,
                authors: [
                    Person(name: "Inal Gotov", uri: nil, email: nil)
                ],
                content: .embedded(Text(type: .html, content: "I’ve been a developer for a number of years now. Primarily iOS. Over the years I’ve learned to use Xcode quite efficiently. I won’t claim to now all the ins and outs of it but I do consider myself to know more than most. Below is a list of my learnings. Perhaps you’ll find them useful.")),
                links: [
                    Link(
                        href: .absolute(URL(string: "https://inalgotov.com/2023/05/01/xcode-bag-of-trick.html")!),
                        relationship: .alternate,
                        type: "text/html",
                        title: "Big bag of Xcode tips & tricks",
                        length: 0
                    ),
                ],
                summary: Text(type: .html, content: "I’ve been a developer for a number of years now. Primarily iOS. Over the years I’ve learned to use Xcode quite efficiently. I won’t claim to now all the ins and outs of it but I do consider myself to know more than most. Below is a list of my learnings. Perhaps you’ll find them useful."),
                categories: [
                    AtomCategory(term: "xcode", scheme: nil, label: nil),
                ],
                contributors: [],
                published: sampleDate,
                rights: nil,
                source: nil
            ),
        ],
        links: [
            Link(
                href: .absolute(URL(string: "https://inalgotov.com/feed.xml")!),
                relationship: .self,
                type: "application/atom+xml",
                title: nil,
                length: 0
            ),
            Link(
                href: .absolute(URL(string: "https://inalgotov.com/")!),
                relationship: .alternate,
                type: "text/html",
                title: nil,
                length: 0
            ),
        ],
        authors: [
            Person(name: "Inal Gotov", uri: nil, email: nil)
        ],
        categories: [],
        contributors: [],
        generator: Generator(name: "Jekyll", uri: URL(string: "https://jekyllrb.com/")!, version: "4.3.2"),
        icon: nil,
        logo: nil,
        rights: nil,
        subtitle: Text(type: .text, content: "Inal's personal webpage")
    )
    
    func _test() throws {
        let feed = try Feed(string: sampleXml)
        
        XCTAssertEqual(feed, expectedFeed)
    }
}


extension Feed: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uri == rhs.uri
        && lhs.title == rhs.title
        && lhs.updated == rhs.updated
        
        && lhs.entries == rhs.entries
        
        && lhs.links == rhs.links
        && lhs.authors == rhs.authors
        
        && lhs.categories == rhs.categories
        && lhs.contributors == rhs.contributors
        && lhs.generator == rhs.generator
        && lhs.icon == rhs.icon
        && lhs.logo == rhs.logo
        && lhs.rights == rhs.rights
        && lhs.subtitle == rhs.subtitle
    }
}
