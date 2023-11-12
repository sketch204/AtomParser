import XCTest
@testable import AtomXML
@testable import AtomParser

final class SkipDaysParsingTests: XCTestCase {
    func test_whenAllDaysProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "skipDays",
            children: [
                AtomXMLNode(name: "day", content: "Sunday"),
                AtomXMLNode(name: "day", content: "Monday"),
                AtomXMLNode(name: "day", content: "Tuesday"),
                AtomXMLNode(name: "day", content: "Wednesday"),
                AtomXMLNode(name: "day", content: "Thursday"),
                AtomXMLNode(name: "day", content: "Friday"),
                AtomXMLNode(name: "day", content: "Saturday"),
            ]
        )
        
        let skipDays = try SkipDays(xmlNode: xml)
        
        XCTAssertEqual(skipDays, .all)
    }
    
    func test_whenNoDaysProvided_parses() throws {
        let xml = AtomXMLNode(name: "skipDays")
        
        let skipDays = try SkipDays(xmlNode: xml)
        
        XCTAssertEqual(skipDays, [])
    }
    
    func test_whenInvalidDaysProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "skipDays",
            children: [
                AtomXMLNode(name: "day", content: "dsa"),
                AtomXMLNode(name: "day", content: "Monday"),
                AtomXMLNode(name: "day", content: "dsa"),
                AtomXMLNode(name: "day", content: "Wednesday"),
            ]
        )
        
        let skipDays = try SkipDays(xmlNode: xml)
        
        XCTAssertEqual(skipDays, [.monday, .wednesday])
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(name: "not skipDays")
        
        XCTAssertThrowsError(try SkipDays(xmlNode: xml))
    }
}
