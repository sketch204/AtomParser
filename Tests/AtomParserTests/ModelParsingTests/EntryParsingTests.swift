import XCTest
@testable import AtomParser

final class EntryParsingTests: XCTestCase {
    
}

extension Entry: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uri == rhs.uri
        && lhs.title == rhs.title
        && lhs.updated == rhs.updated
        && lhs.authors == rhs.authors
        && lhs.content == rhs.content
        && lhs.links == rhs.links
        && lhs.summary == rhs.summary
        && lhs.categories == rhs.categories
        && lhs.contributors == rhs.contributors
        && lhs.published == rhs.published
        && lhs.rights == rhs.rights
        && lhs.source == rhs.source
    }
}
