import XCTest
@testable import AtomXML

 class XMLParserTests: XCTestCase {
    func test_parsesSelfClosingNode() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root/>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(name: "root")
        
        XCTAssertEqual(node, expectedNode)
    }
     
     func test_selfClosingNodeNameIsLowercase() throws {
         let xml = """
         <?xml version="1.0" encoding="utf-8"?>
         <roOt/>
         """
         
         let parser = try AtomXMLParser(string: xml)
         let node = try parser.parse()
         
         XCTAssertEqual(node.name, "root")
     }
    
    func test_parsesSelfClosingNode_withAttributes() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root attr1="value1" attr2="value2"/>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            attributes: [
                "attr1": "value1",
                "attr2": "value2",
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesNode() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root></root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(name: "root")
        
        XCTAssertEqual(node, expectedNode)
    }
     
     func test_nodeNameIsLowercase() throws {
         let xml = """
         <?xml version="1.0" encoding="utf-8"?>
         <rOot></rOot>
         """
         
         let parser = try AtomXMLParser(string: xml)
         let node = try parser.parse()
         
         XCTAssertEqual(node.name, "root")
     }
    
    func test_parsesNode_trimsNewLine_whenNodeNotOnSameLine() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>
        </root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(name: "root")
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesNode_withAttributes() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root attr1="value1" attr2="value2"></root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            attributes: [
                "attr1": "value1",
                "attr2": "value2",
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesNode_withContent() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>This is content</root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            content: "This is content"
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesNode_withContentAndAttributes() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root attr1="value1" attr2="value2">This is content</root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            attributes: [
                "attr1": "value1",
                "attr2": "value2",
            ],
            content: "This is content"
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesChildren_oneLevelDeep() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>
            <child></child>
            <child />
        </root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            children: [
                AtomXMLNode(name: "child"),
                AtomXMLNode(name: "child"),
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesChildren_withAttributes_oneLevelDeep() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>
            <child attr1="value1"></child>
            <child attr2="value2"/>
        </root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            children: [
                AtomXMLNode(
                    name: "child",
                    attributes: [
                        "attr1": "value1",
                    ]
                ),
                AtomXMLNode(
                    name: "child",
                    attributes: [
                        "attr2": "value2",
                    ]
                ),
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesChildren_withContent_oneLevelDeep() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>
            <child>This is content</child>
            <child />
        </root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            children: [
                AtomXMLNode(name: "child", content: "This is content"),
                AtomXMLNode(name: "child"),
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
    
    func test_parsesChildren_withContentAndAttributes_oneLevelDeep() throws {
        let xml = """
        <?xml version="1.0" encoding="utf-8"?>
        <root>
            <child>This is content</child>
            <child attr="value"/>
        </root>
        """
        
        let parser = try AtomXMLParser(string: xml)
        let node = try parser.parse()
        
        let expectedNode = AtomXMLNode(
            name: "root",
            children: [
                AtomXMLNode(name: "child", content: "This is content"),
                AtomXMLNode(
                    name: "child",
                    attributes: [
                        "attr": "value",
                    ]
                ),
            ]
        )
        
        XCTAssertEqual(node, expectedNode)
    }
}

extension AtomXMLNode: Equatable {
    public static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        lhs.name == rhs.name
        && lhs.attributes == rhs.attributes
        && lhs.content == rhs.content
        && lhs.content == rhs.content
    }
}