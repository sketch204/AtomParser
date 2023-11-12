// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AtomParser",
    products: [
        .library(
            name: "AtomParser",
            targets: ["AtomParser"]
        ),
        .library(
            name: "RSSParser",
            targets: ["RSSParser"]
        )
    ],
    targets: [
        .target(
            name: "AtomParser",
            dependencies: ["AtomXML"]
        ),
        .testTarget(
            name: "AtomParserTests",
            dependencies: ["AtomParser", "AtomXML"]
        ),
        
        .target(
            name: "RSSParser",
            dependencies: ["AtomXML"]
        ),
        .testTarget(
            name: "RSSParserTests",
            dependencies: ["RSSParser", "AtomXML"]
        ),
        
        .target(
            name: "AtomXML"
        ),
        .testTarget(
            name: "AtomXMLTests",
            dependencies: ["AtomXML"]
        ),
    ]
)
