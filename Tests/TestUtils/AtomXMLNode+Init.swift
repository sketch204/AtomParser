@testable import AtomXML

extension AtomXMLNode {
    public init(
        name: String,
        attributes: [String : String] = [:],
        content: String = "",
        children: [AtomXMLNode] = []
    ) {
        self.init(
            name: name,
            attributes: attributes,
            content: content,
            path: AtomXMLPath(),
            children: children
        )
    }
}
