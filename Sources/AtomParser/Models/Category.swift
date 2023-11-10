import Foundation

public struct Category {
    public let term: String
    public let scheme: URL?
    public let label: String?
}

extension Category {
    init(xmlNode: XMLNode) throws {
        guard xmlNode.name == "category" else {
            throw ParsingError.invalidNode
        }
        
        guard let term = xmlNode.attributes["term"] else {
            throw ParsingError.missingRequiredFields
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
