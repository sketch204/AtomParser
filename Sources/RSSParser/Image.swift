import Foundation
import AtomXML

struct Image {
    /// The image's link element identifies the URL of the web site represented by the image. This SHOULD be the same URL as the channel's link element.
    let link: URL
    /// The image's title element holds character data that provides a human-readable description of the image
    let title: String
    /// The image's url element identifies the URL of the image, which MUST be in the GIF, JPEG or PNG formats
    let url: URL
    
    /// The image's description element holds character data that provides a human-readable characterization of the site linked to the image
    let description: String?
    /// The image's width element contains the width, in pixels, of the image. The image MUST be no wider than 144 pixels. If this element is omitted, the image is assumed to be 88 pixels wide.
    let width: Int?
    /// The image's height element contains the height, in pixels, of the image. The image MUST be no taller than 400 pixels. If this element is omitted, the image is assumed to be 31 pixels tall.
    let height: Int?
}

extension Image {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("image")
        
        guard let linkNode = xmlNode.childNode(name: "link"),
              let titleNode = xmlNode.childNode(name: "title"),
              let urlNode = xmlNode.childNode(name: "url")
        else { throw MissingRequiredFields() }
        
        guard let linkUrl = URL(string: linkNode.content),
              let url = URL(string: urlNode.content)
        else { throw CorruptedData() }
        
        self.init(
            link: linkUrl,
            title: titleNode.content,
            url: url,
            description: xmlNode.childNode(name: "description")?.content,
            width: xmlNode.childNode(name: "width").flatMap({ Int($0.content) }),
            height: xmlNode.childNode(name: "height").flatMap({ Int($0.content) })
        )
    }
}
