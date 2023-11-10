import Foundation

enum Utils {}

extension Utils {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func parseDate(_ dateString: String) throws -> Date {
        guard let date = dateFormatter.date(from: dateString) else {
            throw ParsingError.invalidDateFormat
        }
        return date
    }
}
