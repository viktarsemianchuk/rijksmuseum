// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalizationKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LocalizationKit",
            targets: ["LocalizationKit"]
        )
    ],
    targets: [
        .target(
            name: "LocalizationKit",
            dependencies: []
        )
    ]
)
