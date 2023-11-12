import AtomXML

public struct SkipDays: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let sunday = Self(rawValue: 1 << 0)
    public static let monday = Self(rawValue: 1 << 1)
    public static let tuesday = Self(rawValue: 1 << 2)
    public static let wednesday = Self(rawValue: 1 << 3)
    public static let thursday = Self(rawValue: 1 << 4)
    public static let friday = Self(rawValue: 1 << 5)
    public static let saturday = Self(rawValue: 1 << 6)
    
    public static let all: Self = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
}


extension SkipDays {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("skipDays")
        
        self = xmlNode.childNodes(name: "day")
            .map(\.content)
            .reduce(SkipDays()) { (output, day) in
                switch day {
                case "Sunday": output.union(.sunday)
                case "Monday": output.union(.monday)
                case "Tuesday": output.union(.tuesday)
                case "Wednesday": output.union(.wednesday)
                case "Thursday": output.union(.thursday)
                case "Friday": output.union(.friday)
                case "Saturday": output.union(.saturday)
                default: output
                }
            }
    }
}
