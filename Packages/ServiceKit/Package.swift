// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ServiceKit",
            targets: ["ServiceKit"]
        )
    ],
    targets: [
        .target(
            name: "ServiceKit",
            dependencies: []
        )
    ]
)
