import Foundation

public final class AtomParser {
    public enum Error: Swift.Error {
        case unableToReadURL
        case unableToReadString
        case failedToParse
    }
    
    private let delegate = ParsingDelegate()
    private let parser: XMLParser
    
    public init(contentsOf url: URL) throws {
        guard let parser = XMLParser(contentsOf: url) else {
            throw Error.unableToReadURL
        }
        
        self.parser = parser
        self.parser.delegate = delegate
    }
    
    public init(data: Data) {
        parser = XMLParser(data: data)
        parser.delegate = delegate
    }
    
    public convenience init(string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw Error.unableToReadString
        }
        self.init(data: data)
    }
    
    public func parse() throws -> Feed {
        guard parser.parse(),
              let tree = delegate.tree
        else { throw Error.failedToParse }
        
        return try Feed(xmlNode: tree)
    }
}
