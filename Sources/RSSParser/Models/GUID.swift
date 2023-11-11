import Foundation
import AtomXML

public struct GUID {
    public let contents: String
    public let isPermaLink: Bool
    
    public var url: URL? {
        URL(string: contents)
    }
}


extension GUID {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("guid")
        
        self.init(
            contents: xmlNode.content,
            isPermaLink: (xmlNode.attributes["isPermaLink"] ?? "true") == "true"
        )
    }
}
