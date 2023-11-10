import Foundation

public struct Link {
    public let url: URL // href
    public let relationship: String?
    public let type: String?
    public let title: String?
    public let length: Int // in bytes
}

extension Link {
    init(xmlNode: AtomXMLNode) throws {
        guard xmlNode.name == "link" else { throw ParsingError.invalidNode }
        
        guard let url = xmlNode.attributes["href"].flatMap(URL.init(string:)) else {
            throw ParsingError.missingRequiredFields
        }
        
        self.init(
            url: url,
            relationship: xmlNode.attributes["rel"],
            type: xmlNode.attributes["type"],
            title: xmlNode.attributes["title"],
            length: xmlNode.attributes["length"].flatMap(Int.init) ?? 0
        )
    }
}
