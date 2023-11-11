import Foundation

private func createDateFormatter(_ formatString: String) -> DateFormatter {
    let output = DateFormatter()
    output.dateFormat = formatString
    return output
}


private let formatters = [
    createDateFormatter("EEE, d MMM yyyy HH:mm:ss zzz"),
    createDateFormatter("EEE, d MMM yyyy HH:mm zzz"),
    createDateFormatter("EEE, d MMM yyyy HH:mm:ss"),
    createDateFormatter("EEE, d MMM yyyy HH:mm"),
    createDateFormatter("d MMM yyyy HH:mm:ss zzz"),
    createDateFormatter("d MMM yyyy HH:mm zzz"),
    createDateFormatter("d MMM yyyy HH:mm:ss"),
    createDateFormatter("d MMM yyyy HH:mm"),
]

func parseDate(_ string: String) throws -> Date {
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
