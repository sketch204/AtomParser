import Foundation
import AtomXML

public struct Link {
    public let href: HypertextReference
    public let relationship: Relationship?
    public let type: String?
    public let title: String?
    public let length: Int // in bytes
}

extension Link {
    public enum HypertextReference: Equatable {
        case absolute(_ url: URL)
        case relative(_ path: String)
    }
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
        try xmlNode.checkName("link")
        
        guard let hrefString = xmlNode.attributes["href"] else {
            throw MissingRequiredFields(
                path: xmlNode.path.replacingLastComponentAttribute(with: "href")
            )
        }
        let href: HypertextReference =
        if (hrefString.hasPrefix("http") || hrefString.hasPrefix("https")), let url = URL(string: hrefString) {
            .absolute(url)
        } else {
            .relative(hrefString)
        }
        
        self.init(
            href: href,
            relationship: xmlNode.attributes["rel"].map(Relationship.init(rawValue:)),
            type: xmlNode.attributes["type"],
            title: xmlNode.attributes["title"],
            length: xmlNode.attributes["length"].flatMap(Int.init) ?? 0
        )
    }
}
