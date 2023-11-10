struct AtomXMLNode {
    var name: String
    var attributes: [String: String] = [:]
    var content: String = ""
    
    var children: [AtomXMLNode] = []
    
    init(
        name: String,
        attributes: [String : String] = [:],
        content: String = "",
        children: [AtomXMLNode] = []
    ) {
        self.name = name
        self.attributes = attributes
        self.content = content
        self.children = children
    }
}

extension AtomXMLNode {
    func childNode(name: String) -> AtomXMLNode? {
        children.first(where: { $0.name == name })
    }
    
    func childNodes(name: String) -> [AtomXMLNode] {
        children.filter({ $0.name == name })
    }
}
