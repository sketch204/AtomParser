import Foundation
import AtomXML

public struct FeedParser {
    let parser: AtomXMLParser
    
    public func parse() throws -> FeedFormat {
        let tree = try parser.parse()
        
        switch tree.name {
        case "feed":
            return try Feed(xmlNode: tree)
            
        case "rss":
            return try RSS(xmlNode: tree)
            
        default:
            throw UnrecognizedFeedFormat(rootNodeName: tree.name)
        }
    }
}

extension FeedParser {
    public init(contentsOf url: URL) throws {
        self.init(parser: try AtomXMLParser(contentsOf: url))
    }
    
    public init(data: Data) throws {
        self.init(parser: AtomXMLParser(data: data))
    }
    
    public init(string: String) throws {
        self.init(parser: try AtomXMLParser(string: string))
    }
}

