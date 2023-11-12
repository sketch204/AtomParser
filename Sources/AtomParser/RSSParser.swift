import Foundation
import AtomXML

struct RSSParser {
    let parser: AtomXMLParser
    
    func parse() throws -> FeedFormat {
        let tree = try parser.parse()
        
        switch tree.name {
        case "feed":
            return try Feed(xmlNode: tree)
            
        case "rss":
            return try RSS(xmlNode: tree)
            
        default:
            throw UnrecognizedFeedFormat()
        }
    }
}

extension RSSParser {
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

