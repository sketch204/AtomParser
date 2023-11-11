import Foundation
import AtomXML

public struct Channel {
    /// The title element holds character data that provides the name of the feed
    public let title: String
    /// The description element holds character data that provides a human-readable characterization or summary of the feed
    public let description: String
    /// The link element identifies the URL of the web site associated with the feed
    public let link: URL

    /// The category element identifies a category or tag to which the feed belongs
    public let categories: [Category]
    /// The copyright element declares the human-readable copyright statement that applies to the feed
    public let copyright: String?
    /// The generator element credits the software that created the feed
    public let generator: String?
    /// The image element supplies a graphical logo for the feed
    public let image: Image?
    /// The channel's language element identifies the natural language employed in the feed
    public let language: String?
    /// The channel's lastBuildDate element indicates the last date and time the content of the feed was updated
    public let lastBuildDate: Date?
    /// The channel's managingEditor element provides the e-mail address of the person to contact regarding the editorial content of the feed
    public let managingEditor: String?
    /// The channel's pubDate element indicates the publication date and time of the feed's content
    public let pubDate: Date?
    /// The channel's skipDays element identifies days of the week during which the feed is not updated
    public let skipDays: SkipDays
    /// The channel's skipHours element identifies the hours of the day during which the feed is not updated
    public let skipHours: SkipHours
    /// The channel's ttl element represents the feed's time to live (TTL): the maximum number of minutes to cache the data before an aggregator requests it again
    public let ttl: Int?
    /// The channel's webMaster element provides the e-mail address of the person to contact about technical issues regarding the feed
    public let webMaster: String?
    
    public let items: [Item]
    
    // Unsupported fields: cloud, docs, rating, textInput
}

extension Channel {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("channel")
        
        guard let titleNode = xmlNode.childNode(name: "title"),
              let descriptionNode = xmlNode.childNode(name: "description"),
              let linkNode = xmlNode.childNode(name: "link")
        else { throw MissingRequiredFields() }
        
        guard let linkUrl = URL(string: linkNode.content) else {
            throw CorruptedData()
        }
        
        self.init(
            title: titleNode.content,
            description: descriptionNode.content,
            link: linkUrl,
            categories: try xmlNode.childNodes(name: "category").map(Category.init(xmlNode:)),
            copyright: xmlNode.childNode(name: "copyright")?.content,
            generator: xmlNode.childNode(name: "generator")?.content,
            image: try xmlNode.childNode(name: "image").map(Image.init(xmlNode:)),
            language: xmlNode.childNode(name: "language")?.content,
            lastBuildDate: try xmlNode.childNode(name: "lastBuildDate").map(\.content).map(parseDate(_:)),
            managingEditor: xmlNode.childNode(name: "managingEditor")?.content,
            pubDate: try xmlNode.childNode(name: "pubDate").map(\.content).map(parseDate(_:)),
            skipDays: try xmlNode.childNode(name: "skipDays").map(SkipDays.init(xmlNode:)) ?? [],
            skipHours: try xmlNode.childNode(name: "skipHours").map(SkipHours.init(xmlNode:)) ?? SkipHours(hours: []),
            ttl: xmlNode.childNode(name: "ttl").flatMap({ Int($0.content) }),
            webMaster: xmlNode.childNode(name: "webMaster")?.content,
            items: try xmlNode.childNodes(name: "item").map(Item.init(xmlNode:))
        )
    }
}
