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
    dependencies: [
        .package(url: "https://github.com/sketch204/AtomXML", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "AtomParser",
            dependencies: ["AtomXML"]
        ),
        .testTarget(
            name: "AtomParserTests",
            dependencies: ["AtomParser", "AtomXML", "TestUtils"]
        ),
        .testTarget(
            name: "RSSParserTests",
            dependencies: ["AtomParser", "AtomXML", "TestUtils"]
        ),
        .target(
            name: "TestUtils",
            dependencies: ["AtomXML"],
            path: "Tests/TestUtils"
        )
    ]
)
