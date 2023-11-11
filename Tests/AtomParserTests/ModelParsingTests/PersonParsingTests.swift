import XCTest
@testable import AtomXML
@testable import AtomParser

final class PersonParsingTests: XCTestCase {
    
}

extension Person: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
        && lhs.uri == rhs.uri
        && lhs.email == rhs.email
    }
}
