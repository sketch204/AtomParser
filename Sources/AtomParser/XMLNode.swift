struct XMLNode {
    var name: String
    var attributes: [String: String] = [:]
    var content: String = ""
    
    var children: [XMLNode] = []
}

extension XMLNode {
    func childNode(name: String) -> XMLNode? {
        children.first(where: { $0.name == name })
    }
    
    func childNodes(name: String) -> [XMLNode] {
        children.filter({ $0.name == name })
    }
}
