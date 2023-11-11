import XCTest
@testable import RSSParser

final class DateParsingTests: XCTestCase {
    func test_parsesDate1() throws {
        let dateString = "Thu, 15 Jun 2023 10:54:15 +0200"
        
        let date = try parseDate(dateString)
        let expectedDate = DateComponents(
            calendar: .current,
            timeZone: TimeZone(secondsFromGMT: 60*60*2),
            year: 2023,
            month: 06,
            day: 15,
            hour: 10,
            minute: 54,
            second: 15
        ).date!
        
        XCTAssertEqual(date, expectedDate)
    }
    
    func test_parsesDate2() throws {
        let dateString = "Tue, 17 Oct 2023 18:35:48 +0000"
        
        let date = try parseDate(dateString)
        let expectedDate = DateComponents(
            calendar: .current,
            timeZone: TimeZone(secondsFromGMT: 60*60*0),
            year: 2023,
            month: 10,
            day: 17,
            hour: 18,
            minute: 35,
            second: 48
        ).date!
        
        XCTAssertEqual(date, expectedDate)
    }
    
    func test_doesNotParseInvalidDateFormats() throws {
        let dateString = "Oct 17 2023, 18:35:48"
        
        XCTAssertThrowsError(try parseDate(dateString))
    }
}
