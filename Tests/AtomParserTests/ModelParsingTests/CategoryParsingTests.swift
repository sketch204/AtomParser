import XCTest
@testable import AtomXML
@testable import AtomParser

final class CategoryParsingTests: XCTestCase {
    
}

extension AtomParser.Category: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.term == rhs.term
        && lhs.scheme == rhs.scheme
        && lhs.label == rhs.label
    }
}
