import Foundation
import AtomXML

public struct RSS {
    public let version: RSSVersion
    public let channel: Channel
}

extension RSS {
    init(xmlNode: AtomXMLNode) throws {
        guard let channelNode = xmlNode.childNode(name: "channel") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "channel"))
        }
        
        self.init(
            version: try RSSVersion(xmlNode: xmlNode),
            channel: try Channel(xmlNode: channelNode)
        )
    }
}

extension RSS {
    private init(parser: AtomXMLParser) throws {
        try self.init(xmlNode: parser.parse())
    }
    
    public init(contentsOf url: URL) throws {
        try self.init(parser: AtomXMLParser(contentsOf: url))
    }
    
    public init(data: Data) throws {
        try self.init(parser: AtomXMLParser(data: data))
    }
    
    public init(string: String) throws {
        try self.init(parser: AtomXMLParser(string: string))
    }
}

