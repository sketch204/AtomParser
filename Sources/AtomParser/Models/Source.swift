import Foundation

public struct Source {
    public let uri: URL // id
    public let title: Text
    public let updated: Date
}

extension Source {
    init(xmlNode: AtomXMLNode) throws {
        guard xmlNode.name == "source" else {
            throw ParsingError.invalidNode
        }
        
        guard let idNode = xmlNode.childNode(name: "id"),
              let titleNode = xmlNode.childNode(name: "title"),
              let updatedNode = xmlNode.childNode(name: "updated")
        else { throw ParsingError.missingRequiredFields }
        
        guard let uri = URL(string: idNode.content) else {
            throw ParsingError.invalidURL
        }
        
        let title = try Text(xmlNode: titleNode)
        let updated = try parseDate(updatedNode.content)
        
        self.init(
            uri: uri,
            title: title,
            updated: updated
        )
    }
}
