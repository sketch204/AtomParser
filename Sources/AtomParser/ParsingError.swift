enum ParsingError: Error {
    case invalidNode
    case missingRequiredFields
    case invalidDateFormat
    case invalidURL
}
