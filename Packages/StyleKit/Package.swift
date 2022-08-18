// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StyleKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "StyleKit",
            targets: ["StyleKit"]
        ),
    ],
    targets: [
        .target(
            name: "StyleKit",
            dependencies: []
        )
    ]
)
