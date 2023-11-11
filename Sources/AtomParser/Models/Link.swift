import Foundation

public struct Link {
    public let url: URL // href
    public let relationship: Relationship?
    public let type: String?
    public let title: String?
    public let length: Int // in bytes
}

extension Link {
    public struct Relationship: RawRepresentable, Equatable {
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static let alternate = Self(rawValue: "alternate")
        public static let enclosure = Self(rawValue: "enclosure")
        public static let related = Self(rawValue: "related")
        public static let `self` = Self(rawValue: "self")
        public static let via = Self(rawValue: "via")
    }
}

extension Link {
    init(xmlNode: AtomXMLNode) throws {
        guard xmlNode.name == "link" else { throw ParsingError.invalidNode }
        
        guard let url = xmlNode.attributes["href"].flatMap(URL.init(string:)) else {
            throw ParsingError.missingRequiredFields
        }
        
        self.init(
            url: url,
            relationship: xmlNode.attributes["rel"].map(Relationship.init(rawValue:)),
            type: xmlNode.attributes["type"],
            title: xmlNode.attributes["title"],
            length: xmlNode.attributes["length"].flatMap(Int.init) ?? 0
        )
    }
}
