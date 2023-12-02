import XCTest
@testable import AtomParser

final class RSSParsingTests: XCTestCase {
    let rssString = """
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0"
        xmlns:content="http://purl.org/rss/1.0/modules/content/"
        xmlns:wfw="http://wellformedweb.org/CommentAPI/"
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns:atom="http://www.w3.org/2005/Atom"
        xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
        xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
        >

    <channel>
        <title>Donny Wals</title>
        <atom:link href="https://www.donnywals.com/feed/" rel="self" type="application/rss+xml" />
        <link>https://www.donnywals.com</link>
        <description>iOS developer, Speaker and Author</description>
        <lastBuildDate>Tue, 17 Oct 2023 18:35:48 +0000</lastBuildDate>
        <language>en-US</language>
        <sy:updatePeriod>
        hourly    </sy:updatePeriod>
        <sy:updateFrequency>
        1    </sy:updateFrequency>
        <generator>https://wordpress.org/?v=5.8</generator>

    <image>
        <url>https://www.donnywals.com/wp-content/uploads/cropped-site-icon-32x32.png</url>
        <title>Donny Wals</title>
        <link>https://www.donnywals.com</link>
        <width>32</width>
        <height>32</height>
    </image>
        <item>
            <title>Making your SwiftData models Codable</title>
            <link>https://www.donnywals.com/making-your-swiftdata-models-codable/</link>
            
            <dc:creator><![CDATA[donnywals]]></dc:creator>
            <pubDate>Tue, 15 Aug 2023 12:56:12 +0000</pubDate>
                    <category><![CDATA[SwiftData]]></category>
            <guid isPermaLink="false">https://www.donnywals.com/?p=2086</guid>

                        <description><![CDATA[In a previous post, I explained how you can make your NSManagedObject subclasses codable. This was a somewhat tedious process that involves a bunch of manual work. Specifically because the most convenient way I've found wasn't all that convenient. It's easy to forget to set your managed object context on your decoder's user info dictionary [&#8230;]]]></description>
                                            <content:encoded><![CDATA[<p>In a previous post, I explained how you can make your subclasses codable. This was a somewhat tedious process that involves a bunch of manual work. Specifically because the most convenient way I&#039;ve found wasn&#039;t all that convenient. It&#039;s easy to forget to set your managed object context on your decoder&#039;s user info dictionary which would result in failed saves in Core Data. With SwiftData it&#039;</p>
    <p><a href="https://www.donnywals.com/making-your-swiftdata-models-codable/" rel="nofollow">Source</a></p>]]></content:encoded>
                        
            
            
                </item>
            <item>
            <title>What&#8217;s the difference between @Binding and @Bindable</title>
            <link>https://www.donnywals.com/whats-the-difference-between-binding-and-bindable/</link>
            
            <dc:creator><![CDATA[donnywals]]></dc:creator>
            <pubDate>Sat, 10 Jun 2023 18:18:16 +0000</pubDate>
                    <category><![CDATA[Swift]]></category>
            <guid isPermaLink="false">https://www.donnywals.com/?p=2052</guid>

                        <description><![CDATA[With iOS 17, macOS Sonoma and the other OSses from this year's generation, Apple has made a couple of changes to how we work with data in SwiftUI. Mainly, Apple has introduced a Combine-free version of @ObservableObject and @StateObject which takes the shape of the @Observable macro which is part of a new package called [&#8230;]]]></description>
                                            <content:encoded><![CDATA[<p>With iOS 17, macOS Sonoma and the other OSses from this year&#039;s generation, Apple has made a couple of changes to how we work with data in SwiftUI. Mainly, Apple has introduced a Combine-free version of and which takes the shape of the macro which is part of a new package called . One interesting addition is the property wrapper. This property wrapper co-exists with in SwiftUI...</p>
    <p><a href="https://www.donnywals.com/whats-the-difference-between-binding-and-bindable/" rel="nofollow">Source</a></p>]]></content:encoded>
                        
            
            
                </item>
        </channel>
    </rss>
    """
    
    let expectedRSS = RSS(
        version: .v2_0,
        channel: Channel(
            title: "Donny Wals",
            description: "iOS developer, Speaker and Author",
            link: URL(string: "https://www.donnywals.com")!,
            categories: [],
            copyright: nil,
            generator: "https://wordpress.org/?v=5.8",
            image: RSSImage(
                websiteUrl: URL(string: "https://www.donnywals.com")!,
                title: "Donny Wals",
                url: URL(string: "https://www.donnywals.com/wp-content/uploads/cropped-site-icon-32x32.png")!,
                description: nil,
                width: 32,
                height: 32
            ),
            language: "en-US",
            lastBuildDate: try! parseRssDate("Tue, 17 Oct 2023 18:35:48 +0000"),
            managingEditor: nil,
            pubDate: nil,
            skipDays: [],
            skipHours: SkipHours(hours: []),
            ttl: nil,
            webMaster: nil,
            items: [
                Item(
                    title: "Making your SwiftData models Codable",
                    description: "In a previous post, I explained how you can make your NSManagedObject subclasses codable. This was a somewhat tedious process that involves a bunch of manual work. Specifically because the most convenient way I've found wasn't all that convenient. It's easy to forget to set your managed object context on your decoder's user info dictionary [&#8230;]",
                    guid: GUID(contents: "https://www.donnywals.com/?p=2086", isPermaLink: false),
                    link: URL(string: "https://www.donnywals.com/making-your-swiftdata-models-codable/")!,
                    author: nil,
                    categories: [RSSCategory(name: "SwiftData", domain: nil)],
                    commentsUrl: nil,
                    pubDate: try! parseRssDate("Tue, 15 Aug 2023 12:56:12 +0000")
                ),
                Item(
                    title: "What’s the difference between @Binding and @Bindable",
                    description: "With iOS 17, macOS Sonoma and the other OSses from this year's generation, Apple has made a couple of changes to how we work with data in SwiftUI. Mainly, Apple has introduced a Combine-free version of @ObservableObject and @StateObject which takes the shape of the @Observable macro which is part of a new package called [&#8230;]",
                    guid: GUID(contents: "https://www.donnywals.com/?p=2052", isPermaLink: false),
                    link: URL(string: "https://www.donnywals.com/whats-the-difference-between-binding-and-bindable/")!,
                    author: nil,
                    categories: [RSSCategory(name: "Swift", domain: nil)],
                    commentsUrl: nil,
                    pubDate: try! parseRssDate("Sat, 10 Jun 2023 18:18:16 +0000")
                ),
            ]
        )
    )
    
    func test() throws {
        let rss = try RSS(string: rssString)
        
        dump(rss)
        dump(expectedRSS)
        XCTAssertEqual(rss, expectedRSS)
    }
}

extension RSS: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.version == rhs.version
        && lhs.channel == rhs.channel
    }
}
