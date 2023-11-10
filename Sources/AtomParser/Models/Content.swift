import Foundation

public enum Content {
    case embedded(Text)
    case linked(URL)
    case embeddedDocument
}

extension Content {
    init(xmlNode: XMLNode) throws {
        guard xmlNode.name == "content" else {
            throw ParsingError.invalidNode
        }
        
        if let src = xmlNode.attributes["src"] {
            if let url = URL(string: src) {
                self = .linked(url)
            } else {
                throw ParsingError.invalidURL
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
            throw ParsingError.missingRequiredFields
        }
    }
}
