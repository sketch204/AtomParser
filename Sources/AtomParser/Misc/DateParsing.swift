import Foundation


// MARK: Atom

let dateFormatter = ISO8601DateFormatter()
    
func parseAtomDate(_ dateString: String) throws -> Date {
    guard let date = dateFormatter.date(from: dateString) else {
        throw UnsupportedDateFormat()
    }
    return date
}


// MARK: RSS

private func createDateFormatter(_ formatString: String) -> DateFormatter {
    let output = DateFormatter()
    output.dateFormat = formatString
    return output
}


private let formatters = [
    // https://www.w3.org/Protocols/rfc822/#z28
    createDateFormatter("EEE, d MMM yyyy HH:mm:ss zzz"),
    createDateFormatter("EEE, d MMM yyyy HH:mm zzz"),
    createDateFormatter("EEE, d MMM yyyy HH:mm:ss"),
    createDateFormatter("EEE, d MMM yyyy HH:mm"),
    createDateFormatter("d MMM yyyy HH:mm:ss zzz"),
    createDateFormatter("d MMM yyyy HH:mm zzz"),
    createDateFormatter("d MMM yyyy HH:mm:ss"),
    createDateFormatter("d MMM yyyy HH:mm"),
]

func parseRssDate(_ string: String) throws -> Date {
    var output: Date?
    let uppercasedString = string.uppercased()
    
    for formatter in formatters {
        guard output == nil else { break }
        output = formatter.date(from: uppercasedString)
    }
    
    guard let output else {
        throw UnsupportedDateFormat()
    }
    
    return output
}

