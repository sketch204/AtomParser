import Foundation
import AtomXML

public struct Person {
    public let name: String
    public let uri: URL?
    public let email: String?
}

extension Person {
    init(xmlNode: AtomXMLNode) throws {
        guard ["author", "contributor"].contains(xmlNode.name) else {
            throw ParsingError.invalidNode
        }
        
        guard let nameNode = xmlNode.childNode(name: "name") else {
            throw ParsingError.missingRequiredFields
        }
        
        let uri: URL? = xmlNode.childNode(name: "uri").flatMap({ URL(string: $0.content) })
        let email: String? = xmlNode.childNode(name: "email")?.content
        
        self.init(
            name: nameNode.content,
            uri: uri,
            email: email
        )
    }
}
