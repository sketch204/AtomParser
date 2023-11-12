import Foundation
import AtomXML

public struct Source {
    public let uri: URL // id
    public let title: Text
    public let updated: Date
}

extension Source {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("source")
        
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
        let updated = try parseAtomDate(updatedNode.content)
        
        self.init(
            uri: uri,
            title: title,
            updated: updated
        )
    }
}
