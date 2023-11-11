import AtomXML

public struct Category {
    public let name: String
    public let domain: String?
}

extension Category {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("category")
        
        self.init(
            name: xmlNode.content,
            domain: xmlNode.attributes["domain"]
        )
    }
}
