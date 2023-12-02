import AtomXML

struct InvalidTagName: Error {
    let tagName: String
    let path: AtomXMLPath
}

struct MissingRequiredFields: Error {
    let path: AtomXMLPath
}

struct UnsupportedDateFormat: Error {
    let dateString: String
    let path: AtomXMLPath?
}

struct UnsupportedRSSVersion: Error {
    let version: String
}

struct InvalidURL: Error {
    let urlString: String
    let path: AtomXMLPath
}

struct UnrecognizedFeedFormat: Error {
    let rootNodeName: String
}
