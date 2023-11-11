import Foundation
import AtomXML

struct Item {
    /// An item's title element holds character data that provides the item's headline. This element is OPTIONAL if the item contains a description element.
    let title: String?
    /// An item's description element holds character data that contains the item's full content or a summary of its contents, a decision entirely at the discretion of the publisher. This element is OPTIONAL if the item contains a title element.
    let description: String?
    /// An item's guid element provides a string that uniquely identifies the item
    let guid: GUID?
    /// An item's link element identifies the URL of a web page associated with the item
    let link: URL?
    /// An item's author element provides the e-mail address of the person who wrote the item
    let author: String?
    /// An item's category element identifies a category or tag to which the item belongs
    let categories: [Category]
    /// An item's comments element identifies the URL of a web page that contains comments received in response to the item
    let commentsUrl: URL?
    /// An item's pubDate element indicates the publication date and time of the item
    let pubDate: Date?
    
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
            categories: try xmlNode.childNodes(name: "category").map(Category.init(xmlNode:)),
            commentsUrl: xmlNode.childNode(name: "comments").flatMap({ URL(string: $0.content) }),
            pubDate: try xmlNode.childNode(name: "pubDate").map({ try parseDate($0.content) })
        )
    }
}