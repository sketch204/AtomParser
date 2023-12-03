import AtomXML

public struct InvalidTagName: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let tagName: String
    let path: AtomXMLPath
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Encountered invalid data in the XML"
    }
    
    public var debugDescription: String {
        "Encountered invalid tag name \(tagName) at xml path: \(path.description)"
    }
}

public struct MissingRequiredFields: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let path: AtomXMLPath
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Missing required data in the XML"
    }
    
    public var debugDescription: String {
        "XML element at path \(path.description) is missing required data"
    }
}

public struct UnsupportedDateFormat: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let dateString: String
    let path: AtomXMLPath?
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Encountered invalid data in the XML"
    }
    
    public var debugDescription: String {
        if let path {
            "XML element at path \(path.description) is using an unsupported date format \(dateString)"
        } else {
            "Encountered an unsupported date format \(dateString)"
        }
    }
}

public struct UnsupportedRSSVersion: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let version: String
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Encountered an invalid version of RSS"
    }
    
    public var debugDescription: String {
        "Encountered an unsupported RSS version string \(version)"
    }
}

public struct InvalidURL: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let urlString: String
    let path: AtomXMLPath
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Encountered invalid data in the XML"
    }
    
    public var debugDescription: String {
        "Encountered an invalid URL \(urlString) at xml path: \(path.description)"
    }
}

public struct UnrecognizedFeedFormat: Error, CustomStringConvertible, CustomDebugStringConvertible {
    let rootNodeName: String
    
    public var localizedDescription: String { description }
    
    public var description: String {
        "Encountered an unsupported feed format."
    }
    
    public var debugDescription: String {
        "Encountered an unsupported feed format. Root XML tag name is \(rootNodeName)"
    }
}
