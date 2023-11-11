import XCTest
@testable import AtomXML
@testable import RSSParser

final class SkipHoursParsingTests: XCTestCase {
    func test_whenAllHoursProvided_parses() throws {
        let xml = AtomXMLNode(
            name: "skipHours",
            children: [
                AtomXMLNode(name: "hour", content: "0"),
                AtomXMLNode(name: "hour", content: "1"),
                AtomXMLNode(name: "hour", content: "2"),
                AtomXMLNode(name: "hour", content: "3"),
                AtomXMLNode(name: "hour", content: "4"),
                AtomXMLNode(name: "hour", content: "5"),
                AtomXMLNode(name: "hour", content: "6"),
                AtomXMLNode(name: "hour", content: "7"),
                AtomXMLNode(name: "hour", content: "8"),
                AtomXMLNode(name: "hour", content: "9"),
                AtomXMLNode(name: "hour", content: "10"),
                AtomXMLNode(name: "hour", content: "11"),
                AtomXMLNode(name: "hour", content: "12"),
                AtomXMLNode(name: "hour", content: "13"),
                AtomXMLNode(name: "hour", content: "14"),
                AtomXMLNode(name: "hour", content: "15"),
                AtomXMLNode(name: "hour", content: "16"),
                AtomXMLNode(name: "hour", content: "17"),
                AtomXMLNode(name: "hour", content: "18"),
                AtomXMLNode(name: "hour", content: "19"),
                AtomXMLNode(name: "hour", content: "20"),
                AtomXMLNode(name: "hour", content: "21"),
                AtomXMLNode(name: "hour", content: "22"),
                AtomXMLNode(name: "hour", content: "23"),
            ]
        )
        
        let skipHours = try SkipHours(xmlNode: xml)
        let expectedSkipHours = SkipHours(hours: [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
        ])
        
        XCTAssertEqual(skipHours, expectedSkipHours)
    }
    
    func test_whenNoHoursProvided_parses() throws {
        let xml = AtomXMLNode(name: "skipHours")
        
        let skipHours = try SkipHours(xmlNode: xml)
        let expectedSkipHours = SkipHours(hours: [])
        
        XCTAssertEqual(skipHours, expectedSkipHours)
    }
    
    func test_whenNonIntHoursProvided_ignoresThenAndParses() throws {
        let xml = AtomXMLNode(
            name: "skipHours",
            children: [
                AtomXMLNode(name: "hour", content: "4"),
                AtomXMLNode(name: "hour", content: "5"),
                AtomXMLNode(name: "hour", content: "dsad"),
                AtomXMLNode(name: "hour", content: "6"),
            ]
        )
        
        let skipHours = try SkipHours(xmlNode: xml)
        let expectedSkipHours = SkipHours(hours: [
            4, 5, 6
        ])
        
        XCTAssertEqual(skipHours, expectedSkipHours)
    }
    
    func test_whenInvalidTag_doesNotParse() throws {
        let xml = AtomXMLNode(name: "not skipHours")
        
        XCTAssertThrowsError(try SkipHours(xmlNode: xml))
    }
}

extension SkipHours: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.hours == rhs.hours
    }
}

extension SkipHours.Hour: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(rawValue: value)
    }
}
