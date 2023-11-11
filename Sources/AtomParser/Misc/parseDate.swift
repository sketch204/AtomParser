import Foundation

let dateFormatter = ISO8601DateFormatter()
    
func parseDate(_ dateString: String) throws -> Date {
    guard let date = dateFormatter.date(from: dateString) else {
        throw UnsupportedDateFormat()
    }
    return date
}
