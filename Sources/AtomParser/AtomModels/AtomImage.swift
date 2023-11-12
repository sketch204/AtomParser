import Foundation
import AtomXML

public struct AtomImage {
    public let path: String
}

extension AtomImage {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("icon", "logo")
        
        self.init(path: xmlNode.content)
    }
}
