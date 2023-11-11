import Foundation
import AtomXML

struct GUID {
    let contents: String
    let isPermaLink: Bool
    
    var url: URL? {
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
