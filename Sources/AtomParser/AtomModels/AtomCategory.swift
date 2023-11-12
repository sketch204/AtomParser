import Foundation
import AtomXML

public struct AtomCategory {
    public let term: String
    public let scheme: URL?
    public let label: String?
}

extension AtomCategory {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("category")
        
        guard let term = xmlNode.attributes["term"] else {
            throw MissingRequiredFields()
        }
        
        let scheme: URL? = xmlNode.attributes["scheme"].flatMap(URL.init(string:))
        let label: String? = xmlNode.attributes["label"]
        
        self.init(
            term: term,
            scheme: scheme,
            label: label
        )
    }
}
