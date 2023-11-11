import AtomXML

extension AtomXMLNode {
    func checkName(_ name: String, _ alternateNames: String...) throws {
        guard ([name] + alternateNames).contains(self.name) else { throw InvalidTagName() }
    }
}
