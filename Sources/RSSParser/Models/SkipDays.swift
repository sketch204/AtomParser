import AtomXML

struct SkipDays: OptionSet {
    let rawValue: Int

    static let sunday = Self(rawValue: 1 << 0)
    static let monday = Self(rawValue: 1 << 1)
    static let tuesday = Self(rawValue: 1 << 2)
    static let wednesday = Self(rawValue: 1 << 3)
    static let thursday = Self(rawValue: 1 << 4)
    static let friday = Self(rawValue: 1 << 5)
    static let saturday = Self(rawValue: 1 << 6)
    
    static let all: Self = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
}


extension SkipDays {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("skipDays")
        
        var output: Self = []
        
        xmlNode.childNodes(name: "day")
            .map(\.content)
            .forEach { day in
                switch day {
                case "Sunday": output.insert(.sunday)
                case "Monday": output.insert(.monday)
                case "Tuesday": output.insert(.tuesday)
                case "Wednesday": output.insert(.wednesday)
                case "Thursday": output.insert(.thursday)
                case "Friday": output.insert(.friday)
                case "Saturday": output.insert(.saturday)
                default: break
                }
            }
        
        self = output
    }
}
