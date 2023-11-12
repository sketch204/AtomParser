import Foundation
import AtomXML

public struct Item {
    /// An item's title element holds character data that provides the item's headline. This element is OPTIONAL if the item contains a description element.
    public let title: String?
    /// An item's description element holds character data that contains the item's full content or a summary of its contents, a decision entirely at the discretion of the publisher. This element is OPTIONAL if the item contains a title element.
    public let description: String?
    /// An item's guid element provides a string that uniquely identifies the item
    public let guid: GUID?
    /// An item's link element identifies the URL of a web page associated with the item
    public let link: URL?
    /// An item's author element provides the e-mail address of the person who wrote the item
    public let author: String?
    /// An item's category element identifies a category or tag to which the item belongs
    public let categories: [RSSCategory]
    /// An item's comments element identifies the URL of a web page that contains comments received in response to the item
    public let commentsUrl: URL?
    /// An item's pubDate element indicates the publication date and time of the item
    public let pubDate: Date?
    
    // Not supported: enclosure, source
}

extension Item {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("item")
        
        let title = xmlNode.childNode(name: "title")?.content
        let description = xmlNode.childNode(name: "description")?.content
        
        guard title != nil || description != nil else {
            throw MissingRequiredFields()
        }
        
        self.init(
            title: title,
            description: description,
            guid: try xmlNode.childNode(name: "guid").map(GUID.init(xmlNode:)),
            link: xmlNode.childNode(name: "link").flatMap({ URL(string: $0.content) }),
            author: xmlNode.childNode(name: "author")?.content,
            categories: try xmlNode.childNodes(name: "category").map(RSSCategory.init(xmlNode:)),
            commentsUrl: xmlNode.childNode(name: "comments").flatMap({ URL(string: $0.content) }),
            pubDate: try xmlNode.childNode(name: "pubDate").map({ try parseRssDate($0.content) })
        )
    }
}
