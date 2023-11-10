import XCTest
@testable import AtomParser

final class ContentParsingTests: XCTestCase {
    
}

extension Content: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.embedded(let lhs), .embedded(let rhs)): lhs == rhs
        case (.linked(let lhs), .linked(let rhs)): lhs == rhs
        case (.embeddedDocument, .embeddedDocument): true
        default: false
        }
    }
}
