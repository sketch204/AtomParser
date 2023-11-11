import Foundation
import AtomXML

struct Channel {
    /// The title element holds character data that provides the name of the feed
    let title: String
    /// The description element holds character data that provides a human-readable characterization or summary of the feed
    let description: String
    /// The link element identifies the URL of the web site associated with the feed
    let link: URL

    /// The category element identifies a category or tag to which the feed belongs
    let categories: [Category]
    /// The copyright element declares the human-readable copyright statement that applies to the feed
    let copyright: String?
    /// The generator element credits the software that created the feed
    let generator: String?
    /// The image element supplies a graphical logo for the feed
    let image: Image?
    /// The channel's language element identifies the natural language employed in the feed
    let language: String?
    /// The channel's lastBuildDate element indicates the last date and time the content of the feed was updated
    let lastBuildDate: Date?
    /// The channel's managingEditor element provides the e-mail address of the person to contact regarding the editorial content of the feed
    let managingEditor: String?
    /// The channel's pubDate element indicates the publication date and time of the feed's content
    let pubDate: Date?
    /// The channel's skipDays element identifies days of the week during which the feed is not updated
    let skipDays: SkipDays
    /// The channel's skipHours element identifies the hours of the day during which the feed is not updated
    let skipHours: SkipHours
    /// The channel's ttl element represents the feed's time to live (TTL): the maximum number of minutes to cache the data before an aggregator requests it again
    let ttl: Int?
    /// The channel's webMaster element provides the e-mail address of the person to contact about technical issues regarding the feed
    let webMaster: String?
    
    let items: [Item]
    
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
