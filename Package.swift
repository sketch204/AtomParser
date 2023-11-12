// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AtomParser",
    products: [
        .library(
            name: "AtomParser",
            targets: ["AtomParser"]
        ),
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
        .testTarget(
            name: "RSSParserTests",
            dependencies: ["AtomParser", "AtomXML"]
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
