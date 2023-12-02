import Foundation
import AtomXML

public enum Content {
    case embedded(Text)
    case linked(URL)
    case embeddedDocument
}

extension Content {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("content")
        
        if let src = xmlNode.attributes["src"] {
            if let url = URL(string: src) {
                self = .linked(url)
            } else {
                throw InvalidURL(
                    urlString: src,
                    path: xmlNode.path.replacingLastComponentAttribute(with: "src")
                )
            }
        }
        else if let type = xmlNode.attributes["type"] {
            if type.hasSuffix("+xml") || type.hasSuffix("/xml") {
                self = .embeddedDocument
            } else {
                self = try .embedded(Text(xmlNode: xmlNode))
            }
        }
        else {
            throw MissingRequiredFields(
                path: xmlNode.path.replacingLastComponentAttribute(with: "type")
            )
        }
    }
}
