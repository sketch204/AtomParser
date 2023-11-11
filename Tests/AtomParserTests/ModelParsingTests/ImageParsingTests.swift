import XCTest
@testable import AtomXML
@testable import AtomParser

final class ImageParsingTests: XCTestCase {
    func test_parses_whenIcon() throws {
        let xml = AtomXMLNode(name: "icon")
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(path: "")
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_parses_whenLogo() throws {
        let xml = AtomXMLNode(name: "logo")
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(path: "")
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_parsesContent() throws {
        let xml = AtomXMLNode(name: "icon", content: "/logo.png")
        
        let image = try Image(xmlNode: xml)
        let expectedImage = Image(path: "/logo.png")
        
        XCTAssertEqual(image, expectedImage)
    }
    
    func test_doesNotParse_whenInvalidNode() throws {
        let xml = AtomXMLNode(name: "not icon")
        
        XCTAssertThrowsError(try Image(xmlNode: xml))
    }
}


extension Image: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.path == rhs.path
    }
}
