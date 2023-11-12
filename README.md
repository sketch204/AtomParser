# AtomParser

This package is can parse [Atom](https://en.wikipedia.org/wiki/Atom_(web_standard)) and [RSS](https://en.wikipedia.org/wiki/RSS_(file_format)) feeds.

## Usage

Parsing can be sourced through a URL, however it is highly recommended that users download the feed themselves before feeding it into the parser.

Assuming you have the feed downloaded, here is how you would parse it.

```Swift
let rawFeedData: Data = downloadFeed()

let parser = try FeedParser(data: rawFeedData)
let feed = parser.parse()
```

The parse function above returns a struct that will conform to the `FeedFormat` protocol. This protocol has no requirements and servers as a marker type. RSS and Atom have significantly different data models. Therefore there are two dedicated sets of types to define a feed. For RSS the top level type is `RSS`. For Atom feeds the top level type is `Feed`.

Once you have a parsed feed, you can check which underlying feed type it is by doing a type check.

```Swift
if let atomFeed = feed as? Feed {
    // It is an atom feed. Do something with it.
}
else if let rssFeed = feed as? RSS {
    // It is an RSS feed. Do something with it.
}
else {
    fatalError("This should never happen")
}
``` 

Alternatively, if you know the type of feed you are working with, both the `Feed` and `RSS` types support direct parsing through one of their `init(contentsOf url: URL)`, `init(data: Data)` or `init(string: String)` initializers.
