import Foundation
import AtomXML

public struct Entry {
    public let uri: URL // id
    public let title: Text
    public let updated: Date
    
    public let authors: [Person]
    public let content: Content?
    public let links: [Link]
    public let summary: Text?
    
    public let categories: [AtomCategory]
    public let contributors: [Person]
    public let published: Date?
    public let rights: Text?
    public let source: Source?
}

extension Entry {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("entry")
        
        guard let idNode = xmlNode.childNode(name: "id") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "id"))
        }
        guard let titleNode = xmlNode.childNode(name: "title") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "title"))
        }
        guard let updatedNode = xmlNode.childNode(name: "updated") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "updated"))
        }
        
        guard let uri = URL(string: idNode.content) else {
            throw InvalidURL(urlString: idNode.content, path: idNode.path)
        }
        
        let title = try Text(xmlNode: titleNode)
        let updated = try parseAtomDate(updatedNode.content, path: updatedNode.path)
        
        
        let authors = try xmlNode.childNodes(name: "author")
            .map(Person.init(xmlNode:))
        let content = try xmlNode.childNode(name: "content")
            .map(Content.init(xmlNode:))
        let links = try xmlNode.childNodes(name: "link")
            .map(Link.init(xmlNode:))
        let summary = try xmlNode.childNode(name: "summary")
            .map(Text.init(xmlNode:))
        
        let categories = try xmlNode.childNodes(name: "category")
            .map(AtomCategory.init(xmlNode:))
        let contributors = try xmlNode.childNodes(name: "contributor")
            .map(Person.init(xmlNode:))
        let published = try xmlNode.childNode(name: "published")
            .map({ try parseAtomDate($0.content, path: $0.path) })
        let rights = try xmlNode.childNode(name: "rights")
            .map(Text.init(xmlNode:))
        let source = try xmlNode.childNode(name: "source")
            .map(Source.init(xmlNode:))
        
        self.init(
            uri: uri,
            title: title,
            updated: updated,
            authors: authors,
            content: content,
            links: links,
            summary: summary,
            categories: categories,
            contributors: contributors,
            published: published,
            rights: rights,
            source: source
        )
    }
}
