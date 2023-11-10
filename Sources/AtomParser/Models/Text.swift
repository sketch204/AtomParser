import Foundation

public struct Text {
    public struct TextType: RawRepresentable {
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static let text = Self(rawValue: "text")
        public static let html = Self(rawValue: "html")
        public static let xhtml = Self(rawValue: "xhtml")
    }
    
    public let type: TextType
    public let content: String
}

extension Text {
    init(xmlNode: AtomXMLNode) throws {
        guard ["title", "summary", "subtitle", "content", "rights"].contains(xmlNode.name) else {
            throw ParsingError.invalidNode
        }
        
        self.init(
            type: xmlNode.attributes["type"].map(TextType.init(rawValue:)) ?? .text,
            content: xmlNode.content
        )
    }
}
