import Foundation
import AtomXML

public struct RSSImage {
    /// The image's link element identifies the URL of the web site represented by the image. This SHOULD be the same URL as the channel's link element.
    public let websiteUrl: URL
    /// The image's title element holds character data that provides a human-readable description of the image
    public let title: String
    /// The image's url element identifies the URL of the image, which MUST be in the GIF, JPEG or PNG formats
    public let url: URL
    
    /// The image's description element holds character data that provides a human-readable characterization of the site linked to the image
    public let description: String?
    /// The image's width element contains the width, in pixels, of the image. The image MUST be no wider than 144 pixels. If this element is omitted, the image is assumed to be 88 pixels wide.
    public let width: Int?
    /// The image's height element contains the height, in pixels, of the image. The image MUST be no taller than 400 pixels. If this element is omitted, the image is assumed to be 31 pixels tall.
    public let height: Int?
}

extension RSSImage {
    init(xmlNode: AtomXMLNode) throws {
        try xmlNode.checkName("image")
        
        guard let linkNode = xmlNode.childNode(name: "link") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "link"))
        }
        guard let titleNode = xmlNode.childNode(name: "title") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "title"))
        }
        guard let urlNode = xmlNode.childNode(name: "url") else {
            throw MissingRequiredFields(path: xmlNode.path.appending(componentName: "url"))
        }
        
        guard let linkUrl = URL(string: linkNode.content) else {
            throw InvalidURL(urlString: linkNode.content, path: linkNode.path)
        }
        
        guard let url = URL(string: urlNode.content) else {
            throw InvalidURL(urlString: urlNode.content, path: urlNode.path)
        }
        
        self.init(
            websiteUrl: linkUrl,
            title: titleNode.content,
            url: url,
            description: xmlNode.childNode(name: "description")?.content,
            width: xmlNode.childNode(name: "width").flatMap({ Int($0.content) }),
            height: xmlNode.childNode(name: "height").flatMap({ Int($0.content) })
        )
    }
}
