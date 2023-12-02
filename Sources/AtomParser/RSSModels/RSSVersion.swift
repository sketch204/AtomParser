import AtomXML

public struct RSSVersion: RawRepresentable, Equatable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension RSSVersion {
    public static let v0_91 = Self(rawValue: "0.91")
    public static let v0_92 = Self(rawValue: "0.92")
    public static let v2_0 = Self(rawValue: "2.0")
}


extension RSSVersion {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("rss")
        
        guard let versionString = xmlNode.attributes["version"] else {
            throw MissingRequiredFields(
                path: xmlNode.path.replacingLastComponentAttribute(with: "version")
            )
        }
        
        guard [Self.v0_91, .v0_92, .v2_0].contains(where: { $0.rawValue == versionString }) else {
            throw UnsupportedRSSVersion(version: versionString)
        }
        
        self.rawValue = versionString
    }
}
