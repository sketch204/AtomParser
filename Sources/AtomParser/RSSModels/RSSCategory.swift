import AtomXML

public struct RSSCategory {
    public let name: String
    public let domain: String?
}

extension RSSCategory {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("category")
        
        self.init(
            name: xmlNode.content,
            domain: xmlNode.attributes["domain"]
        )
    }
}
