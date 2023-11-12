import Foundation
import AtomXML

extension Feed {
    private init(parser: AtomXMLParser) throws {
        try self.init(xmlNode: parser.parse())
    }
    
    public init(contentsOf url: URL) throws {
        try self.init(parser: try AtomXMLParser(contentsOf: url))
    }
    
    public init(data: Data) throws {
        try self.init(parser: AtomXMLParser(data: data))
    }
    
    public init(string: String) throws {
        try self.init(parser: try AtomXMLParser(string: string))
    }
}
