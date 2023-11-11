import Foundation
import AtomXML

public struct Image {
    public let path: String
}

extension Image {
    init(xmlNode: AtomXMLNode) throws {
        guard ["icon", "logo"].contains(xmlNode.name) else {
            throw ParsingError.invalidNode
        }
        
        self.init(path: xmlNode.content)
    }
}
