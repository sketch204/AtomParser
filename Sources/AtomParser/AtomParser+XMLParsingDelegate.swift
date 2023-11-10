import Foundation

extension AtomParser {
    final class ParsingDelegate: NSObject, XMLParserDelegate {
        var tree: XMLNode?
        var stack: [XMLNode] = []
        
        private var accumulatedContent: [String] = []
        
        private var topStackNode: XMLNode? {
            get { stack.last }
            set {
                if let newValue {
                    stack[stack.endIndex - 1] = newValue
                } else {
                    stack.removeLast()
                }
            }
        }
        
        func parserDidStartDocument(_ parser: XMLParser) {
//            print("Did start")
            resetState()
        }
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
//            print("Started element \(elementName), attributes: \(attributeDict)")
            
            startNewNode(name: elementName, attributes: attributeDict)
            accumulatedContent = []
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
//            print("Content: \(string.prefix(100))")
            accumulateContent(string)
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//            print("Ended element \(elementName)")
            
            assert(elementName == topStackNode?.name)
            
            assignAccumulatedStringToTopNode()
            popTopNode()
        }
        
        func parserDidEndDocument(_ parser: XMLParser) {
//            print("Did end")
        }
    
        
        // MARK: Helpers
        
        private func resetState() {
            tree = nil
            stack = []
            accumulatedContent = []
        }
        
        private func startNewNode(name: String, attributes: [String: String]) {
            stack.append(XMLNode(name: name, attributes: attributes))
        }
        
        private func accumulateContent(_ content: String) {
            accumulatedContent.append(content)
        }
        
        private func assignAccumulatedStringToTopNode() {
            topStackNode?.content = accumulatedContent.joined()
            accumulatedContent = []
        }
        
        private func popTopNode() {
            let node = stack.removeLast()
            
            if stack.isEmpty {
                tree = node
            } else {
                topStackNode?.children.append(node)
            }
        }
    }
}
