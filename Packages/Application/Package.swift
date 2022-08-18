// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Application",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Application",
            targets: ["Application"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Application",
            dependencies: []
        ),
        .testTarget(
            name: "ApplicationTests",
            dependencies: ["Application"]
        )
    ]
)
