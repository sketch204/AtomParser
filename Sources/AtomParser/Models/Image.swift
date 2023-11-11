import Foundation
import AtomXML

public struct Image {
    public let path: String
}

extension Image {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("icon", "logo")
        
        self.init(path: xmlNode.content)
    }
}
