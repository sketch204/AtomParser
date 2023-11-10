import XCTest
@testable import AtomParser

final class GeneratorParsingTests: XCTestCase {
    
}

extension Generator: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
        && lhs.uri == rhs.uri
        && lhs.version == rhs.version
    }
}
