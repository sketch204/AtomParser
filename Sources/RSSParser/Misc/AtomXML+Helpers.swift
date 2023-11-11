import AtomXML

extension AtomXMLNode {
    func checkName(_ name: String) throws {
        guard self.name == name else { throw InvalidTagName() }
    }
}
