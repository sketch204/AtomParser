import AtomXML

public struct SkipHours {
    public struct Hour: RawRepresentable, Equatable, Hashable {
        public var rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    public let hours: Set<Hour>
}

extension SkipHours {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("skipHours")
        
        let allHours = xmlNode.childNodes(name: "hour")
            .map(\.content)
            .compactMap(Int.init)
            .map(Hour.init(rawValue:))
        
        self.init(hours: Set(allHours))
    }
}
