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
        
        self.init(
            uri: uri,
            title: title,
            updated: updated
        )
    }
}
