import Foundation
import AtomXML

public struct Feed {
    public let uri: URL // id
    public let title: Text
    public let updated: Date
    
    public let entries: [Entry]
    
    public let links: [Link]
    public let authors: [Person]
    
    public let categories: [Category]
    public let contributors: [Person]
    public let generator: Generator?
    public let icon: Image?
    public let logo: Image?
    public let rights: Text?
    public let subtitle: Text?
}


extension Feed {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("feed")
        
        guard let idNode = xmlNode.childNode(name: "id"),
              let titleNode = xmlNode.childNode(name: "title"),
              let updatedNode = xmlNode.childNode(name: "updated")
        else {
            throw MissingRequiredFields()
        }
        
        guard let uri = URL(string: idNode.content) else {
            throw CorruptedData()
        }
        
        let title = try Text(xmlNode: titleNode)
        let updated = try parseDate(updatedNode.content)
        
        let entries = try xmlNode.childNodes(name: "entry")
            .map(Entry.init(xmlNode:))
        
        let links = try xmlNode.childNodes(name: "link")
            .map(Link.init(xmlNode:))
        let authors = try xmlNode.childNodes(name: "author")
            .map(Person.init(xmlNode:))
        
        let categories = try xmlNode.childNodes(name: "category")
            .map(Category.init(xmlNode:))
        let contributors = try xmlNode.childNodes(name: "contributor")
            .map(Person.init(xmlNode:))
        
        let generator = try xmlNode.childNode(name: "generator")
            .map(Generator.init(xmlNode:))
        let icon = try xmlNode.childNode(name: "icon")
            .map(Image.init(xmlNode:))
        let logo = try xmlNode.childNode(name: "logo")
            .map(Image.init(xmlNode:))
        let rights = try xmlNode.childNode(name: "rights")
            .map(Text.init(xmlNode:))
        let subtitle = try xmlNode.childNode(name: "subtitle")
            .map(Text.init(xmlNode:))
        
        self.init(
            uri: uri,
            title: title,
            updated: updated,
            entries: entries,
            links: links,
            authors: authors,
            categories: categories,
            contributors: contributors,
            generator: generator,
            icon: icon,
            logo: logo,
            rights: rights,
            subtitle: subtitle
        )
    }
}
