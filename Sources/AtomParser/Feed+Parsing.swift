import Foundation
import AtomXML

extension Feed {
    public init(contentsOf url: URL) throws {
        let parser = try AtomXMLParser(contentsOf: url)
        let tree = try parser.parse()
        try self.init(xmlNode: tree)
    }
    
    public init(data: Data) throws {
        let parser = AtomXMLParser(data: data)
        let tree = try parser.parse()
        try self.init(xmlNode: tree)
    }
    
    public init(string: String) throws {
        let parser = try AtomXMLParser(string: string)
        let tree = try parser.parse()
        try self.init(xmlNode: tree)
    }
}
