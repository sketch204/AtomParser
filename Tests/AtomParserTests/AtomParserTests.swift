import XCTest
@testable import AtomParser

final class AtomParserTests: XCTestCase {
    let sampleXml = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
        <generator uri="https://jekyllrb.com/" version="4.3.2">Jekyll</generator>
        <link href="https://inalgotov.com/feed.xml" rel="self" type="application/atom+xml" />
        <link href="https://inalgotov.com/" rel="alternate" type="text/html" />
        <updated>2023-10-17T01:24:18+00:00</updated>
        <id>https://inalgotov.com/feed.xml</id>
        <title type="html">Inal’s Gotov</title>
        <subtitle>Inal&apos;s personal webpage</subtitle>
        <author>
            <name>Inal Gotov</name>
        </author>
        <entry>
            <title type="html">How to use Tables in SwiftUI</title>
            <link href="https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui.html" rel="alternate" type="text/html" title="How to use Tables in SwiftUI" />
            <published>2023-09-07T00:00:00+00:00</published>
            <updated>2023-09-07T00:00:00+00:00</updated>
            <id>https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui</id>
            <content type="html" xml:base="https://inalgotov.com/2023/09/07/how-to-use-tables-in-swiftui.html">
                &lt;p&gt;In this article we’re going to take a quick look at how tables are setup and used in SwiftUI.&lt;/p&gt;
                
                &lt;p&gt;Throughout the article I will be using the following structures as sample data for the tables.&lt;/p&gt;
                
                &lt;p&gt;Just like a &lt;code class=&quot;language-plaintext highlighter-rouge&quot;&gt;List&lt;/code&gt; you can create a table by passing in an array of &lt;code class=&quot;language-plaintext highlighter-rouge&quot;&gt;Identifiable&lt;/code&gt; items inside a &lt;code class=&quot;language-plaintext highlighter-rouge&quot;&gt;Table&lt;/code&gt; view. In a &lt;code class=&quot;language-plaintext highlighter-rouge&quot;&gt;List&lt;/code&gt; this array would be followed by a row builder. That is, a view builder which defines what a row looks like in the list. However for &lt;code class=&quot;language-plaintext highlighter-rouge&quot;&gt;Table&lt;/code&gt;s we must instead define the columns of the table.&lt;/p&gt;
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
            <published>2023-07-15T00:00:00+00:00</published>
            <updated>2023-07-15T00:00:00+00:00</updated>
            <id>https://inalgotov.com/2023/07/15/from-c-to-swift-pt1</id>
            <content type="html" xml:base="https://inalgotov.com/2023/07/15/from-c-to-swift-pt1.html">
                &lt;p&gt;In this article I will walk you through the steps required to set up a C library as a SwiftPM package. This will allow you to use C code within a Swift project. I will then also show you how to use said C code from Swift, as well as how to make it more Swift-friendly.&lt;/p&gt;
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
            <published>2023-07-15T00:00:00+00:00</published>
            <updated>2023-07-15T00:00:00+00:00</updated>
            <id>https://inalgotov.com/2023/07/15/from-c-to-swift-pt2</id>
            <content type="html" xml:base="https://inalgotov.com/2023/07/15/from-c-to-swift-pt2.html">
                &lt;p&gt;In &lt;a href=&quot;/2023/07/15/from-c-to-swift-pt1.html&quot;&gt;part 1&lt;/a&gt; of this series we looked at how we can integrate a C library with SwiftPM such that we can import it into our code. In this article, we will be taking a look at how to actually use the C code, and what the edge cases of using C code in Swift are. If you missed the first part, I highly recommend you give it a read.&lt;/p&gt;
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
            <title type="html">Big bag of Xcode tips &amp;amp; tricks</title>
            <link href="https://inalgotov.com/2023/05/01/xcode-bag-of-trick.html" rel="alternate" type="text/html" title="Big bag of Xcode tips &amp;amp; tricks" />
            <published>2023-05-01T00:00:00+00:00</published>
            <updated>2023-05-01T00:00:00+00:00</updated>
            <id>https://inalgotov.com/2023/05/01/xcode-bag-of-trick</id>
            <content type="html" xml:base="https://inalgotov.com/2023/05/01/xcode-bag-of-trick.html">
                &lt;p&gt;I’ve been a developer for a number of years now. Primarily iOS. Over the years I’ve learned to use Xcode quite efficiently. I won’t claim to now all the ins and outs of it but I do consider myself to know more than most. Below is a list of my learnings. Perhaps you’ll find them useful.&lt;/p&gt;
                
                &lt;p&gt;They are grouped into categories by what they are most closely related to, however they are listed in no particular order. If you wish to integrate them into your daily workflow, I recommend choosing a few at a time and honing them in, rather than trying to jump into all of them at once.&lt;/p&gt;
                
                &lt;p&gt;&lt;em&gt;Word of caution: this is a rather long list :D&lt;/em&gt;&lt;/p&gt;
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
    
    func testExample() throws {
        let parser = try AtomParser(string: sampleXml)
        
        let feed = try parser.parse()
        
        dump(feed)
    }
}
