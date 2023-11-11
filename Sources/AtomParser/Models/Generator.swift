import Foundation
import AtomXML

public struct Generator {
    public let name: String
    public let uri: URL?
    public let version: String?
}

extension Generator {
    init(xmlNode: AtomXMLNode) throws {
        guard xmlNode.name == "generator" else {
            throw ParsingError.invalidNode
        }
        
        self.init(
            name: xmlNode.content,
            uri: xmlNode.attributes["uri"].flatMap(URL.init(string:)),
            version: xmlNode.attributes["version"]
        )
    }
}
